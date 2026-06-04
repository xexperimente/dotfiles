local separator = ' | '

---@class statusline.State
---@field statusline_buf integer|nil
---@field statusline_win integer|nil
---@field lsp_names table<number,table<number,string>>
---@field lsp_progress string
local state = {
	statusline_buf = nil,
	statusline_win = nil,
	lsp_names = {},
	lsp_progress = '',
}

local function with_hl(str, hl)
	if not str or str == '' then return '' end
	return '%#' .. hl .. '#' .. str .. '%#StatusLine#%*'
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('xexperimente/statusline', {})

autocmd({ 'LspAttach', 'LspDetach' }, {
	group = augroup,
	callback = vim.schedule_wrap(function(args)
		local clients = vim.lsp.get_clients({ bufnr = args.buf })

		if not clients or next(clients) == nil then return end

		state.lsp_names[args.buf] = vim.tbl_map(function(client) return client.name end, clients)

		vim.cmd('redrawstatus')
	end),
})

autocmd('LspProgress', {
	group = augroup,
	callback = function(ev)
		state.lsp_progress = with_hl('[ ', 'StatusLineActive')
			.. with_hl(vim.lsp.status(), 'StatusLineDim')
			.. with_hl(' ] ', 'StatusLineActive')
			.. separator

		if ev.data.params.value.kind == 'end' then
			vim.defer_fn(function()
				state.lsp_progress = ''
				vim.cmd('redrawstatus')
			end, 2000)
		end

		vim.cmd('redrawstatus')
	end,
})

local function diagnostics()
	local diag = vim.diagnostic.status()

	if diag:len() > 0 then diag = diag .. separator end

	return diag
end

local function git_status()
	---@diagnostic disable: undefined-field
	local info = vim.b[state.statusline_buf].minidiff_summary
	local summary = vim.b[state.statusline_buf].minigit_summary

	if info == nil or summary == nil then return '' end

	local function value(table, symbol)
		for key, val in pairs(table) do
			if key == symbol then return val end
		end
		return 0
	end

	local head_name = summary.head_name and (' ' .. summary.head_name) or ''
	local head = with_hl(head_name or '', 'StatusLineActive')

	local add = value(info, 'add')
	local cha = value(info, 'change')
	local del = value(info, 'delete')

	local out = (head_name == '' and '' or head .. ' | ')
		.. (add > 0 and with_hl((' %s '):format(add), 'MiniDiffSignAdd') or '')
		.. (cha > 0 and with_hl((' %s '):format(cha), 'MiniDiffSignChange') or '')
		.. (del > 0 and with_hl((' %s '):format(del), 'MiniDiffSignDelete') or '')
		.. ((add + cha + del) > 0 and '| ' or '')

	return out
end

local function lsp_status()
	if state.lsp_progress:len() > 0 then return state.lsp_progress end

	local no_lsp = state.lsp_names == nil
		or state.lsp_names[state.statusline_buf] == nil
		or #state.lsp_names[state.statusline_buf] == 0

	if no_lsp then return '' end

	local server_names = {}

	local ignore_lsp_servers = {
		['null-ls'] = true,
		['copilot'] = true,
	}

	for _, name in ipairs(state.lsp_names[state.statusline_buf]) do
		if not ignore_lsp_servers[name] then server_names[#server_names + 1] = name end
	end

	if package.loaded['guard.filetype'] then
		local ft = require('guard.filetype')

		---@diagnostic disable: call-non-callable
		local formatter = ft(vim.bo.filetype).formatter
		local linter = ft(vim.bo.filetype).linter
		---@diagnostic enable

		vim.list_extend(server_names, vim.tbl_map(function(item) return item.cmd end, formatter and formatter or {}))

		vim.list_extend(server_names, vim.tbl_map(function(item) return item.cmd end, linter and linter or {}))
	end

	local out = #server_names > 0 and table.concat(server_names, ', ') or 'NO LSP, FORMATTERS '

	return with_hl(out, 'StatusLineActive') .. separator
end

local function nvim_mode()
	local mode_map = {
		['n'] = 'NORMAL',
		['no'] = 'O-PENDING',
		['nov'] = 'O-PENDING',
		['noV'] = 'O-PENDING',
		['no\22'] = 'O-PENDING',
		['niI'] = 'NORMAL',
		['niR'] = 'NORMAL',
		['niV'] = 'NORMAL',
		['v'] = 'VISUAL',
		['vs'] = 'VISUAL',
		['V'] = 'V-LINE',
		['Vs'] = 'V-LINE',
		['\22'] = 'V-BLOCK',
		['\22s'] = 'V-BLOCK',
		['s'] = 'SELECT',
		['S'] = 'S-LINE',
		['\19'] = 'S-BLOCK',
		['i'] = 'INSERT',
		['ic'] = 'INSERT',
		['ix'] = 'INSERT',
		['R'] = 'REPLACE',
		['Rc'] = 'REPLACE',
		['Rx'] = 'REPLACE',
		['Rv'] = 'V-REPLACE',
		['Rvc'] = 'V-REPLACE',
		['Rvx'] = 'V-REPLACE',
		['c'] = 'COMMAND',
		['cv'] = 'VIM EX',
		['ce'] = 'EX',
		['r'] = 'PROMPT',
		['rm'] = 'MORE',
		['r?'] = 'CONFIRM',
		['!'] = 'SHELL',
		['t'] = 'TERMINAL',
	}

	local mode_code = vim.api.nvim_get_mode().mode
	local mode = with_hl(mode_map[mode_code] or 'UNKNOWN', 'StatusLineActive')
	return mode .. separator
end

local function filepath()
	local filename = vim.api.nvim_buf_get_name(state.statusline_buf or 0)

	if filename == '' then return ' [No name]' end

	if vim.startswith(filename, 'nvim-pack') then return with_hl('[vim.pack]', 'FloatTitle') end

	if vim.startswith(filename, 'term://') then
		return with_hl('[' .. vim.fs.basename(vim.o.shell) .. ']', 'FloatTitle')
	end

	if vim.startswith(filename, 'health://') then return with_hl('[vim.checkhealth]', 'FloatTitle') end

	if vim.startswith(filename, 'codediff://') then return with_hl('[CodeDiff]', 'FloatTitle') end

	return vim.fn.fnamemodify(filename, ':~:.:gs?\\?/?') .. '%<%w%q %m%r'
end

local function search_count()
	if vim.v.hlsearch == 0 then return '' end

	local ok, s_count = pcall(vim.fn.searchcount, { recompute = 1 })

	---@diagnostic disable-next-line: param-type-mismatch
	if next(s_count) == nil then return '' end
	if not ok or s_count.total == 0 then return '' end

	return with_hl(string.format('[%d/%d]', s_count.current, s_count.total), 'IncSearch') .. separator
end

local function progress()
	local current_line = vim.fn.line('.')
	local total_lines = vim.fn.line('$')

	local percentage = math.floor(current_line / total_lines * 100)
	return with_hl(string.format('%d', percentage) .. '%% ', 'StatusLineHighlight')
end

function _MyStatusline()
	state.statusline_win = vim.g.statusline_winid
	state.statusline_buf = vim.api.nvim_win_get_buf(state.statusline_win)

	return nvim_mode()
		.. git_status()
		.. filepath()
		.. '%='
		.. diagnostics()
		.. lsp_status()
		.. search_count()
		.. '%l:%c | '
		.. progress()
end

vim.o.statusline = '%!v:lua._MyStatusline()'
