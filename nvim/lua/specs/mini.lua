local Plugin = { 'echasnovski/mini.nvim' }
local user = {}

Plugin.lazy = true
Plugin.version = false
Plugin.event = 'VeryLazy'

Plugin.keys = {
	-- Mini.Bufremove
	{ '<leader>bd', ':lua MiniBufremove.delete()<cr>', desc = 'Delete Buffer' },

	-- Mini.Splitjoin
	{ '<leader>uj', ':lua MiniSplitjoin.toggle()<cr>', desc = 'Toggle MiniSplitjoin' },

	-- Mini.Surround
	{ 'sa' }, -- add
	{ 'sd' }, -- delete
	{ 'sf' }, -- find
	{ 'sr' }, -- replace
	{ 'sh' }, -- highlight

	-- Mini.Diff
	{ '<leader>gc', ':lua MiniDiff.toggle_overlay()<cr>', desc = 'Toogle git changes overlay' },
}

function Plugin.config()
	-- Better textobjects
	require('mini.ai').setup({})

	-- Cycle various locations (diagnostics, buffers, etc.)
	require('mini.bracketed').setup({ n_lines = 500 })

	-- Add/Delete/Replace surroundings (brackets, quotes, etc.)
	require('mini.surround').setup()

	-- Delete buffers
	require('mini.bufremove').setup()

	-- Highlight word under cursor
	require('mini.cursorword').setup()

	-- Highlight current block scope
	require('mini.indentscope').setup()

	-- Split/Join
	require('mini.splitjoin').setup()

	-- More textobjects
	require('mini.extra').setup()

	-- Enhanced and repeatable comments
	require('mini.comment').setup()

	-- General icons provider
	require('mini.icons').setup()

	-- Git branch/etc in statusline
	require('mini.git').setup()

	-- Show git changes
	require('mini.diff').setup({ view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } } })

	-- Custom statusline
	user.setup_statusline()

	-- Keybind helper
	user.setup_clue()

	-- Git changes in statusline
	user.setup_diff_summary()
end

function user.setup_clue()
	local clue = require('mini.clue')

	clue.setup({
		triggers = {
			-- Leader triggers
			{ mode = 'n', keys = '<leader>' },
			{ mode = 'x', keys = '<leader>' },

			-- Built-in completion
			{ mode = 'i', keys = '<C-x>' },

			-- `g` key
			{ mode = 'n', keys = 'g' },
			{ mode = 'x', keys = 'g' },

			-- Marks
			{ mode = 'n', keys = "'" },
			{ mode = 'n', keys = '`' },
			{ mode = 'x', keys = "'" },
			{ mode = 'x', keys = '`' },

			-- Registers
			{ mode = 'n', keys = '"' },
			{ mode = 'x', keys = '"' },
			{ mode = 'i', keys = '<C-r>' },
			{ mode = 'c', keys = '<C-r>' },

			-- Window commands
			{ mode = 'n', keys = '<C-w>' },

			-- `z` key
			{ mode = 'n', keys = 'z' },
			{ mode = 'x', keys = 'z' },

			-- Customs
			{ mode = 'n', keys = ']' },
			{ mode = 'n', keys = '[' },
		},

		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
			-- Custom clues
			{ mode = 'n', keys = '<leader>f', desc = 'Pick ' },
			{ mode = 'n', keys = '<leader>g', desc = 'Git ' },
			{ mode = 'n', keys = '<leader>b', desc = 'Buffers ' },
			{ mode = 'n', keys = '<leader>p', desc = 'Plugins ' },
			{ mode = 'n', keys = '<leader>u', desc = 'Options ' },
			{ mode = 'n', keys = '<leader>v', desc = 'Visual ' },
			{ mode = 'n', keys = '<leader>l', desc = 'LSP ' },
			{ mode = 'n', keys = 'zu', desc = 'Undo spelling command ' },
		},
		window = {
			config = {
				width = 'auto',
				border = require('user.env').border,
			},
		},
	})
end

function user.setup_diff_summary()
	local format_summary = function(data)
		local summary = vim.b[data.buf].minidiff_summary

		if summary == nil then return end

		local t = {}
		if summary.add > 0 then table.insert(t, ' ' .. summary.add) end
		if summary.change > 0 then table.insert(t, ' ' .. summary.change) end -- 
		if summary.delete > 0 then table.insert(t, ' ' .. summary.delete) end
		vim.b[data.buf].minidiff_summary_string = table.concat(t, ' ')
	end

	vim.api.nvim_create_autocmd('User', { pattern = 'MiniDiffUpdated', callback = format_summary })
end

user.fmt = string.format

user.hi_pattern = '%%#%s#%s%%*'

function user.setup_statusline()
	local statusline = require('mini.statusline')

	local combine_groups = function(groups)
		local parts = vim.tbl_map(function(s)
			if type(s) == 'string' then return s end
			if type(s) ~= 'table' then return '' end

			local string_arr = vim.tbl_filter(function(x) return type(x) == 'string' and x ~= '' end, s.strings or {})
			local str = table.concat(string_arr, ' ')

			-- Use previous highlight group
			if s.hl == nil then return ' ' .. str .. ' ' end

			-- Allow using this highlight group later
			if str:len() == 0 then return '%#' .. s.hl .. '#' end

			return string.format('%%#%s#%s', s.hl, str)
		end, groups)

		return table.concat(parts, '')
	end

	statusline.setup({
		content = {
			active = function()
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 50 })
				local git = MiniStatusline.section_git({ trunc_width = 40 })
				local diff = user.statusline_gitchanges()
				local diagnostics = user.statusline_diagnostics()
				local lsp = user.statusline_formatters()
				local filename = MiniStatusline.section_filename({ trunc_width = 140 })
				local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

				local tab = {
					{ hl = mode_hl, strings = { ' ' .. mode:upper() .. ' ' } },
					{ hl = 'MiniStatuslineFilename', strings = { ' ' } },
					{ hl = 'MiniStatuslineFilename', strings = { filename } },
					' ',
					'%<', -- Mark general truncate point
				}

				if table.concat({ git, diff }):len() > 0 then
					table.insert(tab, { hl = '@comment.todo', strings = { ' ' .. git .. ' ' } })
					table.insert(tab, { hl = 'StatusLine', strings = { ' ' } })
					table.insert(tab, { hl = 'MiniStatuslineDevinfo', strings = { diff } })
					table.insert(tab, { hl = 'StatusLine', strings = { '%<' } }) -- Mark general truncate point
				end
				table.insert(tab, '%=')

				if table.concat({ diagnostics, lsp }):len() > 0 then
					table.insert(tab, { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } })
					table.insert(tab, { hl = 'StatusLine', strings = { ' ' } })
				end

				table.insert(tab, { hl = mode_hl, strings = { user.statusline_lazystatus() } })
				table.insert(tab, { hl = 'StatusLine', strings = { ' ' } })

				table.insert(tab, { hl = mode_hl, strings = { search } })
				table.insert(tab, { hl = 'MiniStatuslineDevinfo', strings = { user.statusline_position() } })
				table.insert(tab, { hl = 'MiniStarterItemPrefix', strings = { user.statusline_percent() } })

				return combine_groups(tab)
			end,
			inactive = nil,
		},
	})
end

function user.statusline_diagnostics()
	local get_option = vim.api.nvim_get_option_value
	local get_name = vim.api.nvim_buf_get_name
	local diagnostic = vim.diagnostic

	if get_option('filetype', { scope = 'local' }) == 'lazy' and get_name(0):match('%.env$') then return '' end

	local result = {}

	local icons = { ERROR = '', INFO = '', HINT = '󰌵', WARN = '' }
	local order = { 'ERROR', 'WARN', 'INFO', 'HINT' }
	local colors = { 'DiagnosticError', 'DiagnosticWarn', 'DiagnosticInfo', 'DiagnosticHint' }

	local should_add_spacing = false
	for index, key in ipairs(order) do
		local count = #diagnostic.get(0, { severity = diagnostic.severity[key] })

		if count > 0 then
			if should_add_spacing then
				result[index] = user.fmt(user.hi_pattern, colors[index], ' ' .. icons[key] .. ' ' .. count)
			else
				should_add_spacing = true
				result[index] = user.fmt(user.hi_pattern, colors[index], icons[key] .. ' ' .. count)
			end
		else
			result[index] = ''
		end
	end
	return table.concat(result, '')
end

function user.statusline_gitchanges()
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
				result[index] = user.fmt(user.hi_pattern, colors[index], ' ' .. icons[v] .. ' ' .. git_status[v])
			else
				should_add_spacing = true
				result[index] = user.fmt(user.hi_pattern, colors[index], icons[v] .. ' ' .. git_status[v])
			end
		else
			result[index] = ''
		end
	end
	return table.concat(result, '')
end

function user.statusline_position() return user.fmt(user.hi_pattern, 'UserStatuslineBlock', 'Ln %l, Col %-2c') end

function user.statusline_formatters()
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

	return user.fmt(user.hi_pattern, 'UserStatuslineHighlight2', text)
end

function user.statusline_lazystatus()
	local ok, status = pcall(require, 'lazy.status')

	if ok and status.has_updates() then
		return user.fmt(user.hi_pattern, 'UserStatuslineVisualMode', ' ' .. status.updates() .. ' ') or ''
	end

	return ''
end

function user.statusline_percent() return user.fmt(user.hi_pattern, 'UserStatuslineHighlight1', ' %p%% ') end

return Plugin
