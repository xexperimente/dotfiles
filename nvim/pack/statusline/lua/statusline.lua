local M = {}
local state = {}

function vim.g.statusline_component(name) return state[name]() end

local mode_higroups = {
	['NORMAL'] = 'UserStatuslineNormalMode',
	['VISUAL'] = 'UserStatuslineVisualMode',
	['V-BLOCK'] = 'UserStatuslineVisualMode',
	['V-LINE'] = 'UserStatuslineVisualMode',
	['INSERT'] = 'UserStatuslineInsertMode',
	['REPLACE'] = 'UserStatuslineReplaceMode',
	['COMMAND'] = 'UserStatuslineCommandMode',
	['TERMINAL'] = 'UserStatuslineTerminalMode',
}

-- mode_map copied from:
-- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
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

local fmt = string.format
local hi_pattern = '%%#%s#%s%%*'

state.show_diagnostic = false
state.mode_group = mode_higroups['NORMAL']

function state.mode()
	local mode = vim.api.nvim_get_mode().mode
	local mode_name = mode_map[mode]
	local text = ' '

	local higroup = mode_higroups[mode_name]

	state.mode_group = higroup
	text = fmt(' %s ', mode_name)
	return fmt(hi_pattern, state.mode_group, text)
end

function state.position() return fmt(hi_pattern, 'UserStatuslineBlock', 'Ln %l, Col %-2c ') end

function state.formatters()
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
			if linters ~= nil and #linters > 0 then
				table.insert(server_names, table.concat(linters, ','))
			end
		end
	end

	local text = #server_names > 0 and table.concat(server_names, ', ') or 'NO LSP, NO FORMAT '

	return fmt(hi_pattern, 'UserStatuslineHighlight2', text)
end

function state.lazy_status()
	local ok, status = pcall(require, 'lazy.status')

	if ok and status.has_updates() then
		return fmt(hi_pattern, 'UserStatuslineVisualMode', ' ' .. status.updates() .. ' ') or ''
	end

	return ''
end

state.percent = fmt(hi_pattern, 'UserStatuslineHighlight1', ' %p%% ')

function state.filename()
	local buf_modified = vim.api.nvim_get_option_value('modified', {})
	local buf_readonly = vim.api.nvim_get_option_value('readonly', {})
	local filename = vim.fn.expand('%:t')
	if filename == '' then
		local cwd = vim.fn.getcwd()
		filename = string.gsub(cwd, vim.env.HOME, '~')
	end
	return filename
		.. (buf_modified and fmt(hi_pattern, 'UserStatuslineHighlight2', ' *') or '')
		.. (buf_readonly and fmt(hi_pattern, 'UserStatuslinehighlight2', ' ro') or '')
end

function state.git_branch()
	local get_branch = function()
		local git_dir = vim.fn.finddir('.git', '.;')
		if git_dir ~= '' then
			local head_file = io.open(git_dir .. '/HEAD', 'r')
			if head_file then
				local content = head_file:read('*all')
				head_file:close()
				-- branch name  or commit hash
				return content:match('ref: refs/heads/(.-)%s*$') or content:sub(1, 7) or ''
			end
			return ''
		end
		return ''
	end
	local branch = get_branch()
	local text = ''
	if string.len(branch) > 0 then text = '  ' .. get_branch() .. ' ' end
	-- return fmt(hi_pattern, 'UserStatuslineReplaceMode', text)
	return fmt(hi_pattern, '@comment.todo', text)
end

function state.git_changes()
	if vim.b.gitsigns_status_dict == nil or vim.o.columns < 70 then return '' end

	local git_status = vim.b.gitsigns_status_dict

	local order = { 'added', 'changed', 'removed' }
	local icons = {
		added = '',
		changed = '',
		removed = '',
	}
	local colors = { 'DiagnosticSignInfo', 'DiagnosticSignWarn', 'DiagnosticSignError' }

	local should_add_spacing = false
	local result = {}
	for index, v in ipairs(order) do
		if git_status[v] and git_status[v] > 0 then
			if should_add_spacing then
				result[index] = fmt(hi_pattern, colors[index], ' ' .. icons[v] .. ' ' .. git_status[v])
			else
				should_add_spacing = true
				result[index] = fmt(hi_pattern, colors[index], icons[v] .. ' ' .. git_status[v])
			end
		else
			result[index] = ''
		end
	end
	return table.concat(result, '')
end

function state.lsp_diagnostic()
	local get_option = vim.api.nvim_get_option_value
	local get_name = vim.api.nvim_buf_get_name
	local diagnostic = vim.diagnostic

	if get_option('filetype', { scope = 'local' }) == 'lazy' and get_name(0):match('%.env$') then
		return ''
	end

	local result = {}

	local icons = { ERROR = '', INFO = '', HINT = '󰌵', WARN = '' }
	local order = { 'ERROR', 'WARN', 'INFO', 'HINT' }
	local colors = { 'DiagnosticError', 'DiagnosticWarn', 'DiagnosticInfo', 'DiagnosticHint' }

	local should_add_spacing = false
	for index, key in ipairs(order) do
		local count = #diagnostic.get(0, { severity = diagnostic.severity[key] })

		if count > 0 then
			if should_add_spacing then
				result[index] = fmt(hi_pattern, colors[index], ' ' .. icons[key] .. ' ' .. count)
			else
				should_add_spacing = true
				result[index] = fmt(hi_pattern, colors[index], icons[key] .. ' ' .. count)
			end
		else
			result[index] = ''
		end
	end
	return table.concat(result, '')
end

state.full_status = {
	'%{%v:lua.vim.g.statusline_component("mode")%} ',
	-- '%t',
	'%{%v:lua.vim.g.statusline_component("filename")%} ',
	'%{%v:lua.vim.g.statusline_component("git_branch")%} ',
	'%{%v:lua.vim.g.statusline_component("git_changes")%} ',
	-- '%r',
	-- '%m',
	'%=',
	-- '%{&filetype} ',
	'%{%v:lua.vim.g.statusline_component("lsp_diagnostic")%} ',
	'%{%v:lua.vim.g.statusline_component("formatters")%} ',
	'%{%v:lua.vim.g.statusline_component("lazy_status")%} ',
	'%{%v:lua.vim.g.statusline_component("position")%}',
	state.percent,
}

state.short_status = {
	state.full_status[1],
	'%=',
	state.percent,
	state.full_status[8],
}

state.inactive_status = {
	'%t',
	'%r',
	'%m',
	'%=',
	'%{&filetype} |',
	' %2p%% | ',
	'%3l:%-2c ',
}

function M.setup()
	local augroup = vim.api.nvim_create_augroup('UserStatuslineCmds', { clear = true })
	local autocmd = vim.api.nvim_create_autocmd

	vim.opt.showmode = false

	local pattern = M.get_status('full')
	if pattern then vim.o.statusline = pattern end

	-- autocmd('ColorScheme', {
	-- 	group = augroup,
	-- 	desc = 'Apply statusline highlights',
	-- 	callback = apply_hl,
	-- })
	autocmd('FileType', {
		group = augroup,
		pattern = { 'ctrlsf', 'Neogit*', 'Mini*' },
		desc = 'Apply short statusline',
		callback = function()
			vim.w.status_style = 'short'
			vim.wo.statusline = M.get_status('short')
		end,
	})
	autocmd('InsertEnter', {
		group = augroup,
		desc = 'Clear message area',
		command = "echo ''",
	})
	autocmd('LspAttach', {
		group = augroup,
		desc = 'Show diagnostic sign',
		callback = function()
			vim.b.lsp_attached = 1
			state.show_diagnostic = true
		end,
	})
	autocmd('DiagnosticChanged', {
		group = augroup,
		desc = 'Show diagnostic sign',
		callback = function()
			vim.b.lsp_attached = 1
			state.show_diagnostic = true

			local style = vim.w.status_style
			if style == nil then
				style = 'full'
				vim.w.status_style = style
			end

			vim.wo.statusline = M.get_status(style)
		end,
	})
	autocmd('WinEnter', {
		group = augroup,
		desc = 'Change statusline',
		callback = function()
			local winconfig = vim.api.nvim_win_get_config(0)
			if winconfig.relative ~= '' then return end

			local style = vim.w.status_style
			if style == nil then
				style = 'full'
				vim.w.status_style = style
			end

			vim.wo.statusline = M.get_status(style)

			local winnr = vim.fn.winnr('#')
			if winnr == 0 then return end

			local curwin = vim.api.nvim_get_current_win()
			local winid = vim.fn.win_getid(winnr)
			if winid == 0 or winid == curwin then return end

			if vim.api.nvim_win_is_valid(winid) then
				vim.wo[winid].statusline = M.get_status('inactive')
			end
		end,
	})
end

function M.get_status(name) return table.concat(state[fmt('%s_status', name)], '') end

function M.apply(name) vim.o.statusline = M.get_status(name) end

return M
