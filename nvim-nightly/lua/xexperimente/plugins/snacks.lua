vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local fn = require('xexperimente.utils.functions')

require('snacks').setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	input = { enabled = true },
	image = { enabled = false },
	explorer = { replace_netrw = true },
	notifier = { enabled = true, style = 'compact' },
	words = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	scratch = { icon = '󰄶' },
	statuscolumn = {
		left = { 'mark', 'sign' },
		right = { 'fold', 'git' },
		folds = {
			open = true, -- show open fold icons
			git_hl = true, -- use Git Signs hl for fold icons
		},
		git = {
			-- patterns to match Git signs
			patterns = { 'GitSign', 'MiniDiffSign' },
		},
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
			wo = {
				winbar = '',
				statusline = '',
			},
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
						border = 'rounded',
						title = ' Files ',
						title_pos = 'center',
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
				layout = { preset = 'vertical', preview = false, layout = { backdrop = 60 } },
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
			{ section = 'recent_files', padding = 1 },
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
			border = 'rounded',
		},
	},
})

-- Keymaps
local bind = vim.keymap.set
local config = vim.fn.stdpath('config')

-- Toggle options
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.dim():map('<leader>uD')
Snacks.toggle.treesitter():map('<leader>uT')

-- Top Pickers & Explorer
bind('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
bind('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
bind('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
bind('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
bind('n', '<leader>N', function() Snacks.notifier.show_history() end, { desc = 'Notifier History' })
bind('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })
bind('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
bind('n', '<leader>;', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })

-- find
bind('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
bind('n', '<leader>fc', function() Snacks.picker.files({ cwd = config }) end, { desc = 'Find in Config' })
bind('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
bind('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find Git Files' })
bind('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Projects' })
bind('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent' })

-- git
bind('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
bind('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
bind('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
bind('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
bind('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
bind('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
bind('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })

-- gh
bind('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
bind('n', '<leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, { desc = 'GitHub Issues (all)' })
bind('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
bind('n', '<leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end, { desc = 'GitHub Pull Requests (all)' })

-- grep
bind('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
bind('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
bind('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
bind({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })

-- search
bind('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
bind('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
bind('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
bind('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
bind('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
bind('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
bind('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
bind('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
bind('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
bind('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
bind('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
bind('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
bind('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
bind('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
bind('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
bind('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
bind('n', '<leader>sp', function() fn.show_plugins() end, { desc = 'Show plugins' })
bind('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
bind('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
bind('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
bind('n', '<leader>st', function() Snacks.picker.colorschemes() end, { desc = 'Themes' })

-- LSP
bind('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
bind('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
bind('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
bind('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
bind('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
bind('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'C[a]lls Incoming' })
bind('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'C[a]lls Outgoing' })
bind('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
bind('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

-- Terminal
bind('n', '<leader>t', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })
bind('n', '<c-t>', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })

-- Utils
bind('n', '<leader>bD', function() Snacks.bufdelete.other() end, { desc = 'Delete other buffers' })
bind('n', '<leader>bd', function() Snacks.bufdelete(0) end, { desc = 'Delete buffer' })

-- Show messages, info or notifications
bind('n', '<leader>m', function() fn.show_messages() end, { desc = 'Show Messages' })
bind('n', '<leader>i', function() fn.show_info() end, { desc = 'Show Neovim News' })

-- Debug print
_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end

vim.print = _G.dd -- Override print to use snacks for `:=` command
