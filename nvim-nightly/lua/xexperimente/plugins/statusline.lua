local function highlight(text, group) return string.format('%%#%s#%s%%*', group, text) end
local function filename() return highlight('%t', 'StatuslineDim') end
local function position() return highlight('%l:%c', 'StatuslineDim') end
local function percent() return highlight('%p%%', 'StatuslineHighlight') end

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
		['nt'] = 'NORMAL',
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
		['cv'] = 'EX',
		['ce'] = 'EX',
		['r'] = 'REPLACE',
		['rm'] = 'MORE',
		['r?'] = 'CONFIRM',
		['!'] = 'SHELL',
		['t'] = 'TERMINAL',
	}

	local m = vim.api.nvim_get_mode().mode
	local mode_name = mode_map[m]

	return highlight(mode_name, 'StatuslineActive')
end

local function loaded_lsp()
	local server_names = {}
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

	local ignore_lsp_servers = {
		['null-ls'] = true,
		['copilot'] = true,
	}

	for _, client in pairs(buf_clients) do
		local client_name = client.name
		if not ignore_lsp_servers[client_name] then table.insert(server_names, client_name) end
	end

	if package.loaded['conform'] then
		local has_conform, conform = pcall(require, 'conform')
		if has_conform then
			vim.list_extend(
				server_names,
				vim.tbl_map(function(formatter) return formatter.name end, conform.list_formatters(0))
			)
		end
	end

	if package.loaded['lint'] then
		local has_lint, lint = pcall(require, 'lint')
		if has_lint then
			local linters = lint.linters_by_ft[vim.bo.filetype]
			if linters ~= nil and #linters > 0 then table.insert(server_names, table.concat(linters, ',')) end
		end
	end

	local text = #server_names > 0 and table.concat(server_names, ', ') or 'NO LSP, NO FORMAT'

	return highlight(text, 'StatuslineActive')
end

local function branch()
	local summary = vim.b.minigit_summary_string or vim.b.gitsigns_head
	if summary == nil then return '' end

	return highlight(' ' .. (summary == '' and '-' or summary), 'StatuslineActive') .. ' | '
end

local function changes()
	local git_status = vim.b.minidiff_summary

	if git_status == nil or vim.o.columns < 70 then return '' end

	local order = { 'add', 'change', 'delete' }
	local icons = {
		add = '',
		change = '',
		delete = '',
	}
	local colors = { 'MiniDiffSignAdd', 'MiniDiffSignChange', 'MiniDiffSignDelete' }

	local should_add_spacing = false
	local result = {}
	for index, v in ipairs(order) do
		if git_status[v] and git_status[v] > 0 then
			if should_add_spacing then
				result[index] = highlight(' ' .. icons[v] .. ' ' .. git_status[v], colors[index])
			else
				should_add_spacing = true
				result[index] = highlight(icons[v] .. ' ' .. git_status[v], colors[index])
			end
		else
			result[index] = ''
		end
	end
	return ' | ' .. table.concat(result, '')
end

function diagnostics()
	if next(vim.diagnostic.count(nil, {})) == nil then return '' end

	local result = {}

	local icons = { ERROR = '', INFO = '', HINT = '󰌵', WARN = '' }
	local order = { 'ERROR', 'WARN', 'INFO', 'HINT' }
	local colors = { 'DiagnosticError', 'DiagnosticWarn', 'DiagnosticInfo', 'DiagnosticHint' }

	local should_add_spacing = false
	for index, key in ipairs(order) do
		local count = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity[key] })

		if count > 0 then
			if should_add_spacing then
				result[index] = highlight(' ' .. icons[key] .. ' ' .. count, colors[index])
			else
				should_add_spacing = true
				result[index] = highlight(icons[key] .. ' ' .. count, colors[index])
			end
		else
			result[index] = ''
		end
	end
	return table.concat(result, '') .. ' | '
end

local function search_count()
	-- `searchcount()` can return errors because it is evaluated very often in
	-- statusline. For example, when typing `/` followed by `\(`, it gives E54.
	local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
	if not ok or s_count.current == nil or s_count.total == 0 then return '' end

	if s_count.incomplete == 1 then return '?/?' end

	local too_many = '>' .. s_count.maxcount
	local current = s_count.current > s_count.maxcount and too_many or s_count.current
	local total = s_count.total > s_count.maxcount and too_many or s_count.total
	return highlight('Search: ', 'StatuslineDim')
		.. highlight(' ' .. current .. '/' .. total .. ' ', 'FloatTitle')
		.. ' | '
end

_G.Statusline = {}

function _G.Statusline.active()
	return table.concat({
		mode(),
		' | ',
		branch(),
		filename(),
		changes(),
		'%=',
		diagnostics(),
		loaded_lsp(),
		' | ',
		search_count(),
		position(),
		' | ',
		percent(),
	})
end

function _G.Statusline.inactive() return ' %t ' end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('StatuslineCommands', { clear = true })

autocmd({ 'ModeChanged', 'BufEnter', 'DiagnosticChanged' }, {
	group = augroup,
	desc = 'Handle state',
	callback = function() vim.wo.statusline = '%!v:lua._G.Statusline.active()' end,
})

autocmd('LspAttach', {
	group = augroup,
	desc = 'Show diagnostic sign in statusline',
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then return end

		---@diagnostic disable-next-line: param-type-not-match
		if client:supports_method('textDocument/diagnostics', {}) then vim.cmd('redrawstatus') end
	end,
})
