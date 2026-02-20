vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local fn = require('xexperimente.utils.functions')

require('snacks').setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	input = { enabled = true },
	image = { enabled = false },
	explorer = { replace_netrw = true },
	notifier = { enabled = true, style = 'compact' },
	notify = { enabled = true },
	words = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	scratch = { icon = '󰄶' },
	statuscolumn = {
		left = { 'mark', 'sign' },
		right = { 'fold', 'git' },
		folds = { open = true, git_hl = true },
		git = { patterns = { 'GitSign', 'MiniDiffSign' } },
		refresh = 50, -- refresh at most every 50ms
	},
	terminal = {
		win = {
			position = 'float',
			border = 'single',
			style = 'terminal',
			keys = {
				term_hide = {
					'<C-t>',
					function(self) self:hide() end,
					mode = 't',
					expr = true,
				},
			},
			wo = { winbar = '', statusline = '' },
			title = ' Terminal ',
		},
		interactive = true,
	},
	picker = {
		sources = {
			files = {
				layout = {
					preview = false,
					layout = {
						box = 'vertical',
						width = 0.7,
						height = 0.8,
						border = 'single',
						title = ' Files ',
						title_pos = 'center',
						backdrop = 90,
						{ win = 'input', height = 1, border = 'bottom' },
						{
							box = 'horizontal',
							{ win = 'list', border = 'none' },
							{ win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
						},
					},
				},
				exclude = { 'zig-out/', 'node_modules', 'vendor', 'vcpkg_installed', 'build', 'target', 'out' },
			},
			explorer = {
				tree = true,
				auto_close = true,
				git_status = false,
				layout = { preset = 'vertical', preview = false, layout = { backdrop = 90 } },
			},
			icons = { layout = 'select' },
			pickers = { preview = false, layout = 'select' },
			git_status = { preview = false, layout = 'select' },
			search_history = { preview = false, layout = 'select' },
			help = { preview = false, layout = 'select' },
			keymaps = { layout = { preview = false } },
			qflist = { layout = 'vertical' },
			loclist = { layout = 'vertical' },
			recent = {
				layout = 'select',
				filter = {
					paths = {
						[vim.fn.stdpath('data')] = false,
						[vim.fn.stdpath('cache')] = false,
						[vim.fn.stdpath('state')] = false,
					},
				},
			},
		},
	},
	dashboard = {
		width = 80,
		preset = {
			header = require('xexperimente.utils.dashboard'),
			keys = {
				{ key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')", icon = '' },
				{ key = 'r', desc = 'Recent Projects', action = ":lua Snacks.dashboard.pick('projects')", icon = '' },
				{ key = 'c', desc = 'Config', action = function() fn.open_config() end, icon = '' },
				{ key = 'p', desc = 'Update plugins', action = ':lua vim.pack.update()', icon = '' },
				{ key = 'q', desc = 'Quit', action = ':qa', icon = '' },
			},
		},
		sections = {
			{ section = 'header' },
			{ section = 'recent_files', cwd = true, padding = 1 },
			{ section = 'keys', gap = 0 },
		},
		formats = {
			icon = function(_) return '' end,
			file = fn.dashboard_file_format,
		},
	},
	styles = {
		notification_history = {
			border = 'single',
			width = 0.8,
			keys = { ['<Esc>'] = 'close' },
		},
		scratch = {
			border = 'single',
			keys = { ['<Esc>'] = 'close' },
			wo = { winhighlight = 'NormalFloat:NormalFloat' },
		},
		input = {
			row = 36,
			wo = { winhighlight = 'FloatBorder:FloatBorder' },
			border = 'single',
		},
	},
})

-- Keymaps
local bind = vim.keymap.set
local config = vim.fn.stdpath('config')
local nxm = { 'n', 'x' }

-- Toggle options
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.dim():map('<leader>uD')
Snacks.toggle.treesitter():map('<leader>uT')

-- Top Pickers & Explorer
bind('n', '<leader>,', Snacks.picker.buffers, { desc = 'Buffers' })
bind('n', '<leader>/', Snacks.picker.grep, { desc = 'Grep' })
bind('n', '<leader>:', Snacks.picker.command_history, { desc = 'Command History' })
bind('n', '<leader>n', Snacks.picker.notifications, { desc = 'Notifier History' })
bind('n', '<leader>N', Snacks.notifier.show_history, { desc = 'Notifier History' })
bind('n', '<leader>e', Snacks.picker.explorer, { desc = 'File Explorer' })
bind('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Scratch Buffer' })
bind('n', '<leader>;', Snacks.scratch.select, { desc = 'Select Scratch Buffer' })

-- find
bind('n', '<leader>fb', Snacks.picker.buffers, { desc = 'Buffers' })
bind('n', '<leader>ff', Snacks.picker.files, { desc = 'Find Files' })
bind('n', '<leader>fg', Snacks.picker.git_files, { desc = 'Find Git Files' })
bind('n', '<leader>fp', Snacks.picker.projects, { desc = 'Projects' })
bind('n', '<leader>fc', function() Snacks.picker.files({ cwd = config }) end, { desc = 'Find in Config' })
bind('n', '<leader>fr', function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = 'Recent(cwd)' })
bind('n', '<leader>fR', Snacks.picker.recent, { desc = 'Recent' })

-- git
bind('n', '<leader>gb', Snacks.picker.git_branches, { desc = 'Git Branches' })
bind('n', '<leader>gl', Snacks.picker.git_log, { desc = 'Git Log' })
bind('n', '<leader>gL', Snacks.picker.git_log_line, { desc = 'Git Log Line' })
bind('n', '<leader>gs', Snacks.picker.git_status, { desc = 'Git Status' })
bind('n', '<leader>gS', Snacks.picker.git_stash, { desc = 'Git Stash' })
bind('n', '<leader>gd', Snacks.picker.git_diff, { desc = 'Git Diff (Hunks)' })
bind('n', '<leader>gf', Snacks.picker.git_log_file, { desc = 'Git Log File' })
bind('n', '<leader>gi', Snacks.picker.gh_issue, { desc = 'GitHub Issues (open)' })
bind('n', '<leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, { desc = 'GitHub Issues (all)' })
bind('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub PR (open)' })
bind('n', '<leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end, { desc = 'GitHub PR (all)' })

-- grep
bind('n', '<leader>sb', Snacks.picker.lines, { desc = 'Buffer Lines' })
bind('n', '<leader>sB', Snacks.picker.grep_buffers, { desc = 'Grep Open Buffers' })
bind('n', '<leader>sg', Snacks.picker.grep, { desc = 'Grep' })
bind(nxm, '<leader>sw', Snacks.picker.grep_word, { desc = 'Visual selection or word' })

-- search
bind('n', '<leader>s"', Snacks.picker.registers, { desc = 'Registers' })
bind('n', '<leader>s/', Snacks.picker.search_history, { desc = 'Search History' })
bind('n', '<leader>sa', Snacks.picker.autocmds, { desc = 'Autocmds' })
bind('n', '<leader>sb', Snacks.picker.lines, { desc = 'Buffer Lines' })
bind('n', '<leader>sc', Snacks.picker.command_history, { desc = 'Command History' })
bind('n', '<leader>sC', Snacks.picker.commands, { desc = 'Commands' })
bind('n', '<leader>sd', Snacks.picker.diagnostics, { desc = 'Diagnostics' })
bind('n', '<leader>sD', Snacks.picker.diagnostics_buffer, { desc = 'Buffer Diagnostics' })
bind('n', '<leader>sh', Snacks.picker.help, { desc = 'Help Pages' })
bind('n', '<leader>sH', Snacks.picker.highlights, { desc = 'Highlights' })
bind('n', '<leader>si', Snacks.picker.icons, { desc = 'Icons' })
bind('n', '<leader>sj', Snacks.picker.jumps, { desc = 'Jumps' })
bind('n', '<leader>sk', Snacks.picker.keymaps, { desc = 'Keymaps' })
bind('n', '<leader>sl', Snacks.picker.loclist, { desc = 'Location List' })
bind('n', '<leader>sm', Snacks.picker.marks, { desc = 'Marks' })
bind('n', '<leader>sM', Snacks.picker.man, { desc = 'Man Pages' })
bind('n', '<leader>sq', Snacks.picker.qflist, { desc = 'Quickfix List' })
bind('n', '<leader>sR', Snacks.picker.resume, { desc = 'Resume' })
bind('n', '<leader>su', Snacks.picker.undo, { desc = 'Undo History' })
bind('n', '<leader>st', Snacks.picker.colorschemes, { desc = 'Themes' })

-- LSP
bind('n', 'gd', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
bind('n', 'gD', Snacks.picker.lsp_declarations, { desc = 'Goto Declaration' })
bind('n', 'gr', Snacks.picker.lsp_references, { nowait = true, desc = 'References' })
bind('n', 'gI', Snacks.picker.lsp_implementations, { desc = 'Goto Implementation' })
bind('n', 'gy', Snacks.picker.lsp_type_definitions, { desc = 'Goto Type Definition' })
bind('n', 'gai', Snacks.picker.lsp_incoming_calls, { desc = 'C[a]lls Incoming' })
bind('n', 'gao', Snacks.picker.lsp_outgoing_calls, { desc = 'C[a]lls Outgoing' })
bind('n', '<leader>ss', Snacks.picker.lsp_symbols, { desc = 'LSP Symbols' })
bind('n', '<leader>sS', Snacks.picker.lsp_workspace_symbols, { desc = 'LSP Workspace Symbols' })
bind('n', '<leader>cl', Snacks.picker.lsp_config, { desc = 'Lsp Info' })
bind('n', '<leader>cR', Snacks.rename.rename_file, { desc = 'Rename File' })

-- Visual Studio LSP binds
bind('n', '<f12>', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
bind('n', '<s-f12>', Snacks.picker.lsp_references, { desc = 'References' })
bind('n', '<c-f12>', Snacks.picker.lsp_declarations, { desc = 'Goto Declaration' })

-- Terminal
bind('n', '<leader>t', Snacks.terminal.toggle, { desc = 'Toggle terminal' })
bind('n', '<c-t>', Snacks.terminal.toggle, { desc = 'Toggle terminal' })

-- Utils
bind('n', '<leader>bD', Snacks.bufdelete.other, { desc = 'Delete other buffers' })
bind('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete buffer' })

-- Debug print
_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end

vim.print = _G.dd -- Override print to use snacks for `:=` command
