---@diagnostic disable: param-type-mismatch

local state = {
	diagnostic_count = {},
	lsp_client_names = {},
	statusline_buf = nil,
	statusline_win = nil,
	statusline_is_active = false,
}

vim.api.nvim_create_autocmd('Colorscheme', {
	desc = 'Set statusline highlights',
	group = vim.api.nvim_create_augroup('statusline-highlights', {}),
	callback = function()
		vim.api.nvim_set_hl(0, 'User2', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg }) -- error
		vim.api.nvim_set_hl(0, 'User3', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg }) -- warning
		vim.api.nvim_set_hl(0, 'User4', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg }) -- info
		vim.api.nvim_set_hl(0, 'User5', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg }) -- hint
		vim.api.nvim_set_hl(0, 'User6', { fg = vim.api.nvim_get_hl(0, { name = 'Special' }).fg }) -- git branch
	end,
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
	group = vim.api.nvim_create_augroup('statusline-diagnostics', {}),
	callback = vim.schedule_wrap(function(args)
		if vim.fn.mode() == 'i' then return end
		state.diagnostic_count[args.buf] = vim.api.nvim_buf_is_valid(args.buf) and vim.diagnostic.count(args.buf or 0)
		vim.cmd('redrawstatus')
	end),
})

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach' }, {
	group = vim.api.nvim_create_augroup('statusline-lsp', {}),
	callback = vim.schedule_wrap(function(args)
		state.lsp_client_names[args.buf] = vim.tbl_map(
			function(client) return client.name end,
			vim.lsp.get_clients({ bufnr = args.buf })
		)

		vim.cmd('redrawstatus')
	end),
})

local function with_hl(str, hl, hl_nc)
	if not str or str == '' then return '' end
	if state.statusline_is_active then
		return '%#' .. hl .. '#' .. str .. '%#StatusLine#%*'
	else
		return '%#' .. (hl_nc or 'StatusLineNC') .. '#' .. str .. '%#StatusLineNC#%*'
	end
end

local function get_severity_hl(severity_id)
	-- severity_id je např. vim.diagnostic.severity.ERROR (což je 1)
	if severity_id == 1 then return 'DiagnosticError' end
	if severity_id == 2 then return 'DiagnosticWarn' end
	if severity_id == 3 then return 'DiagnosticInfo' end
	if severity_id == 4 then return 'DiagnosticHint' end
	return 'StatuslineActive'
end

local function diagnostics()
	local diagnostic_count = state.diagnostic_count[state.statusline_buf]
	if diagnostic_count == nil then return '' end
	local out = ''
	for severity, count in pairs(diagnostic_count) do
		if count > 0 then
			---@diagnostic disable-next-line: need-check-nil
			local icon = vim.diagnostic.config().signs.text[severity]

			local fmt = ('%s %d'):format(icon, count)
			out = out .. with_hl(fmt, get_severity_hl(severity))
		end
	end
	return out ~= '' and (' ' .. out) or ''
end

local function git_status()
	-- local git_info = vim.b[state.statusline_buf].gitsigns_status_dict
	local info = vim.b[state.statusline_buf].minidiff_summary
	local summary = vim.b[state.statusline_buf].minigit_summary

	if info == nil then return '' end

	local head_name = summary.head_name and ('' .. summary.head_name) or ''
	local out = ''
	local head = with_hl(head_name or '', 'StatusLineActive')
	local added = (info.add and info.add > 0) and with_hl(' ' .. info.add .. ' ', 'MiniDiffSignAdd') or ''
	local changed = (info.change and info.change > 0) and with_hl(' ' .. info.change .. ' ', 'MiniDiffSignChange')
		or ''
	local removed = (info.delete and info.delete > 0) and with_hl(' ' .. info.delete .. '', 'MiniDiffSignDelete') or ''

	local changes = ('%s%s%s'):format(added, changed, removed)
	out = out .. ('%s%s'):format(head, changes == '' and '' or ' | ' .. changes)
	-- idk if this can be empty
	return out ~= '' and (' ' .. out) or ''
end

local function lsp_status()
	local client_names = state.lsp_client_names[state.statusline_buf]
	if client_names == nil or client_names == 0 then return '' end
	local out = ''
	for i, name in ipairs(client_names) do
		out = out .. name .. (i ~= #client_names and ', ' or '')
	end
	out = with_hl(out, 'StatusLineActive')
	return '| ' .. out
end

local function filepath()
	local filename = vim.api.nvim_buf_get_name(state.statusline_buf)
	if filename == '' then return ' [No name]' end
	return ' | ' .. vim.fn.fnamemodify(filename, ':~:.')
end

local function mode()
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
	local m = with_hl(mode_map[mode_code] or 'UNKNOWN', 'StatusLineActive')
	return m .. ' |'
end

local function search_count()
	-- Pokud není aktivní hledání (není nastaven registr /), nevracíme nic
	if vim.v.hlsearch == 0 then return '' end

	-- searchcount vrací tabulku: {current, total, incomplete, ...}
	local ok, s_count = pcall(vim.fn.searchcount, { recompute = 1 })

	if not ok or s_count.total == 0 then return '' end

	return string.format('| [%d/%d]', s_count.current, s_count.total)
end

local function progress()
	local current_line = vim.fn.line('.')
	local total_lines = vim.fn.line('$')

	local percentage = math.floor(current_line / total_lines * 100)
	return with_hl(string.format('%d', percentage) .. '%% ', 'StatusLineHighlight')
end

function MyStatusline()
	state.statusline_win = vim.g.statusline_winid
	state.statusline_buf = vim.api.nvim_win_get_buf(state.statusline_win)
	state.statusline_is_active = vim.g.statusline_winid == vim.api.nvim_get_current_win()
	return mode()
		.. git_status()
		.. filepath()
		.. '%<%w%q %m%r%='
		.. diagnostics()
		.. ' '
		.. lsp_status()
		.. search_count()
		.. ' | %l:%c | '
		.. progress()
end

vim.o.statusline = '%!v:lua.MyStatusline()'

-- vim.pack.add({ 'https://github.com/sontungexpt/witch-line' })
--
-- local opts = {
-- 	auto_theme = false,
-- 	cache = {
-- 		enabled = false,
-- 		notification = false,
-- 		func_strip = false,
-- 	},
-- 	statusline = {
-- 		global = {
-- 			{
-- 				[0] = 'mode',
-- 				timing = true,
-- 				static = {
-- 					mode_colors = {
-- 						[1] = { fg = 'StatusLineActive' }, -- NORMAL
-- 						[2] = { fg = 'StatusLineActive' }, -- NTERMINAL
-- 						[3] = { fg = 'StatusLineActive' }, -- VISUAL
-- 						[4] = { fg = 'StatusLineActive' }, -- INSERT
-- 						[5] = { fg = 'StatusLineActive' }, -- TERMINAL
-- 						[6] = { fg = 'StatusLineActive' }, -- REPLACE
-- 						[7] = { fg = 'StatusLineActive' }, -- SELECT
-- 						[8] = { fg = 'StatusLineActive' }, -- COMMAND
-- 						[9] = { fg = 'StatusLineActive' }, -- CONFIRM
-- 					},
-- 				},
-- 			},
-- 			{
-- 				[0] = 'git.branch',
-- 				left = '|',
-- 				style = { fg = 'StatusLineActive' },
-- 			},
-- 			{
-- 				[0] = 'git.diff.added',
-- 				static = { icon = '' },
-- 				left = '|',
-- 				style = { fg = 'MiniDiffSignAdd' },
-- 			},
-- 			{
-- 				[0] = 'git.diff.modified',
-- 				static = { icon = '' },
-- 				style = { fg = 'MiniDiffSignChange' },
-- 			},
-- 			{
-- 				[0] = 'git.diff.removed',
-- 				static = { icon = '' },
-- 				style = { fg = 'MiniDiffSignDelete' },
-- 			},
-- 			{
-- 				[0] = 'file.name',
-- 				left = '|',
-- 				style = { fg = 'StatusLineDim' },
-- 				-- update = function() return '%t' end,
-- 			},
-- 			{
-- 				[0] = 'file.modifier',
-- 				padding = 0,
-- 				style = { fg = 'StatusLineDim' },
-- 			},
-- 			'%=',
-- 			'diagnostic.info',
-- 			'diagnostic.warn',
-- 			'diagnostic.error',
-- 			'lsp.clients',
-- 			{
-- 				[0] = 'search.count',
-- 				timing = 200,
-- 				style = { link = 'IncSearch' },
-- 				left = '|',
-- 			},
-- 			{
-- 				[0] = 'encoding',
-- 				left = '|',
-- 			},
-- 			{
-- 				[0] = 'cursor.pos',
-- 				left = '|',
-- 				style = { fg = 'StatusLineDim' },
-- 			},
-- 			{
-- 				id = 'tst.progress',
-- 				update = function(_, _) return '%p%%' end,
-- 				events = 'CursorMoved',
-- 				left = '|',
-- 				style = { fg = 'StatusLineHighlight', bg = 'NONE' },
-- 			},
-- 		},
-- 		win = nil,
-- 	},
-- 	disabled = {
-- 		filetypes = { 'snacks_dashboard' },
-- 		-- buftypes = { 'nofile' },
-- 	},
-- }
--
-- require('witch-line').setup(opts)
