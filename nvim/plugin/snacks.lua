local add_on_event = require('pack').add_on_event

vim.o.winborder = vim.g.winborder

add_on_event('UIEnter', {
	{
		src = 'folke/snacks.nvim',
		opts = {
			bigfile = { enabled = true },
			explorer = { replace_netrw = true },
			image = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			notifier = { enabled = true, style = 'compact' },
			notify = { enabled = true },
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
					border = vim.g.winborder,
					style = 'terminal',
					wo = { winbar = '', statusline = '' },
					title = ' Terminal ',
					backdrop = 95,
				},
				interactive = true,
			},
			picker = {
				sources = {
					explorer = {
						tree = true,
						auto_close = true,
						git_status = false,
						layout = { preset = 'vertical', preview = false, layout = { backdrop = 90 } },
					},
					files = {
						layout = { preview = false },
						exclude = { 'zig-out/', 'node_modules', 'vendor', 'vcpkg_installed', 'build', 'target', 'out' },
					},
					buffers = { layout = 'select' },
					help = { layout = 'select' },
					icons = { layout = 'select' },
					pickers = { layout = 'select' },
					git_status = { layout = 'select' },
					command_history = { layout = 'select' },
					search_history = { layout = 'select' },
					keymaps = { layout = { preview = false } },
					qflist = { layout = 'vertical' },
					loclist = { layout = 'vertical' },
					diagnostics = { layout = { preset = 'vertical', layout = { width = 0.65 } } },
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
			quickfile = { enabled = true },
			words = { enabled = false },
			dashboard = {
				enabled = true,
				width = 80,
				preset = {
					header = require('icons').art,
					keys = {
						-- { key = 'r', desc = 'Recent Projects', action = ":lua Snacks.dashboard.pick('projects')", icon = '' },
						{ key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent({ cwd= true})', icon = '' },
						{ key = 'u', desc = 'Update plugins', action = ':lua vim.pack.update(nil, { force = true})', icon = '' },
						{ key = 'q', desc = 'Quit', action = ':qa', icon = '' },
					},
				},
				sections = {
					{ section = 'header' },
					{ section = 'recent_files', cwd = true, padding = 1 },
					{ section = 'keys', gap = 0 },
					function()
						local startup_time = string.format('%sms', vim.g.nvim_startup_time or '0')

						return {
							align = 'center',
							text = {
								{ 'Loaded in ', hl = 'SnacksDashboardDir' },
								{ startup_time, hl = 'SnacksDashboardKey' },
							},
						}
					end,
				},
				formats = {
					icon = function(_) return '' end,
					file = require('functions').dashboard_file_format,
					key = function(item)
						return { { '[ ', hl = 'Whitespace' }, { item.key, hl = 'key' }, { ' ]', hl = 'Whitespace' } }
					end,
				},
			},
			styles = {
				notification_history = { width = 0.8, keys = { ['<Esc>'] = 'close' } },
				scratch = { keys = { ['<Esc>'] = 'close' }, wo = { winhighlight = 'NormalFloat:NormalFloat' } },
				input = { row = 36, wo = { winhighlight = 'FloatBorder:FloatBorder' } },
				terminal = { wo = { winhighlight = 'NormalFloat:Normal,FloatBorder:Border' } },
			},
		},
		on_setup = function()
			local bind = vim.keymap.set
			local config = vim.fn.stdpath('config')

			-- Toggle options
			-- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
			-- Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
			-- Snacks.toggle.diagnostics():map('<leader>ud')
			-- Snacks.toggle.line_number():map('<leader>ul')
			-- Snacks.toggle.inlay_hints():map('<leader>uh')
			-- Snacks.toggle.dim():map('<leader>uD')
			-- Snacks.toggle.treesitter():map('<leader>uT')
			-- Snacks.toggle.words():map('<leader>uW')
			local picker = Snacks.picker

			-- Top Pickers & Explorer
			bind('n', '<leader>,', picker.buffers, { desc = 'Buffers' })
			bind('n', '<leader>/', picker.grep, { desc = 'Grep' })
			bind('n', '<leader>:', picker.command_history, { desc = 'Command History' })
			bind('n', '<leader>e', picker.explorer, { desc = 'File Explorer' })
			bind('n', '<leader>n', picker.notifications, { desc = 'Notifier History' })
			bind('n', '<leader>N', Snacks.notifier.show_history, { desc = 'Notifier History' })
			bind('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Scratch Buffer' })
			bind('n', '<leader>;', Snacks.scratch.select, { desc = 'Select Scratch Buffer' })

			-- find
			bind('n', '<leader>fb', picker.buffers, { desc = 'Buffers' })
			bind('n', '<leader>ff', picker.files, { desc = 'Find Files' })
			bind('n', '<leader>fg', picker.git_files, { desc = 'Find Git Files' })
			bind('n', '<leader>fp', picker.projects, { desc = 'Projects' })
			bind('n', '<leader>fc', function() picker.files({ cwd = config }) end, { desc = 'Find in Config' })
			bind('n', '<leader>fr', function() picker.recent({ filter = { cwd = true } }) end, { desc = 'Recent(cwd)' })
			bind('n', '<leader>fR', picker.recent, { desc = 'Recent' })

			-- git
			bind('n', '<leader>gb', picker.git_branches, { desc = 'Git Branches' })
			bind('n', '<leader>gl', picker.git_log, { desc = 'Git Log' })
			bind('n', '<leader>gL', picker.git_log_line, { desc = 'Git Log Line' })
			bind('n', '<leader>gs', picker.git_status, { desc = 'Git Status' })
			bind('n', '<leader>gS', picker.git_stash, { desc = 'Git Stash' })
			bind('n', '<leader>gd', picker.git_diff, { desc = 'Git Diff (Hunks)' })
			bind('n', '<leader>gf', picker.git_log_file, { desc = 'Git Log File' })

			-- grep
			bind('n', '<leader>sb', picker.lines, { desc = 'Buffer Lines' })
			bind('n', '<leader>sB', picker.grep_buffers, { desc = 'Grep Open Buffers' })
			bind('n', '<leader>sg', picker.grep, { desc = 'Grep' })
			bind({ 'n', 'x' }, '<leader>sw', picker.grep_word, { desc = 'Visual selection or word' })

			-- search
			bind('n', '<leader>s"', picker.registers, { desc = 'Registers' })
			bind('n', '<leader>s/', picker.search_history, { desc = 'Search History' })
			bind('n', '<leader>sa', picker.autocmds, { desc = 'Autocmds' })
			bind('n', '<leader>sb', picker.lines, { desc = 'Buffer Lines' })
			bind('n', '<leader>sc', picker.command_history, { desc = 'Command History' })
			bind('n', '<leader>sC', picker.commands, { desc = 'Commands' })
			bind('n', '<leader>sd', picker.diagnostics, { desc = 'Diagnostics' })
			bind('n', '<leader>sD', picker.diagnostics_buffer, { desc = 'Buffer Diagnostics' })
			bind('n', '<leader>sh', picker.help, { desc = 'Help Pages' })
			bind('n', '<leader>sH', picker.highlights, { desc = 'Highlights' })
			bind('n', '<leader>si', picker.icons, { desc = 'Icons' })
			bind('n', '<leader>sj', picker.jumps, { desc = 'Jumps' })
			bind('n', '<leader>sk', picker.keymaps, { desc = 'Keymaps' })
			bind('n', '<leader>sl', picker.loclist, { desc = 'Location List' })
			bind('n', '<leader>sm', picker.marks, { desc = 'Marks' })
			bind('n', '<leader>sM', picker.man, { desc = 'Man Pages' })
			bind('n', '<leader>sq', picker.qflist, { desc = 'Quickfix List' })
			bind('n', '<leader>sR', picker.resume, { desc = 'Resume' })
			bind('n', '<leader>su', picker.undo, { desc = 'Undo History' })
			bind('n', '<leader>st', picker.colorschemes, { desc = 'Themes' })

			-- LSP
			bind('n', 'gd', picker.lsp_definitions, { desc = 'Goto Definition' })
			bind('n', 'gD', picker.lsp_declarations, { desc = 'Goto Declaration' })
			bind('n', 'gr', picker.lsp_references, { nowait = true, desc = 'References' })
			bind('n', 'gI', picker.lsp_implementations, { desc = 'Goto Implementation' })
			bind('n', 'gy', picker.lsp_type_definitions, { desc = 'Goto Type Definition' })
			bind('n', 'gai', picker.lsp_incoming_calls, { desc = 'C[a]lls Incoming' })
			bind('n', 'gao', picker.lsp_outgoing_calls, { desc = 'C[a]lls Outgoing' })
			bind('n', '<leader>ss', picker.lsp_symbols, { desc = 'LSP Symbols' })
			bind('n', '<leader>sS', picker.lsp_workspace_symbols, { desc = 'LSP Workspace Symbols' })
			bind('n', '<leader>cL', picker.lsp_config, { desc = 'Lsp Info' })
			bind('n', '<leader>cR', Snacks.rename.rename_file, { desc = 'Rename File' })

			-- Visual Studio LSP binds
			bind('n', '<f12>', picker.lsp_definitions, { desc = 'Goto Definition' })
			bind('n', '<s-f12>', picker.lsp_references, { desc = 'References' })
			-- bind('n', '<c-f12>', picker.lsp_declarations, { desc = 'Goto Declaration' })

			-- Terminal
			local nt = { 'n', 't' }
			local pos = { win = { position = 'right' } }

			-- bind(nt, '<leader>t', Snacks.terminal.toggle, { desc = 'Toggle terminal' })
			bind(nt, '<leader>T', function() Snacks.terminal.open(nil, pos) end, { desc = 'Toggle termina(right)' })
			-- bind(nt, '<c-t>', Snacks.terminal.toggle, { desc = 'Toggle terminal' })
			bind(nt, '<c-_>', Snacks.terminal.toggle, { desc = 'Toggle terminal' })
			bind(nt, '<c-/>', Snacks.terminal.toggle, { desc = 'Toggle terminal' })

			-- Buffers
			bind('n', '<leader>bD', Snacks.bufdelete.other, { desc = 'Delete other buffers' })
			bind('n', '<leader>bd', Snacks.bufdelete.delete, { desc = 'Delete buffer' })
			bind('n', '<leader>bx', Snacks.bufdelete.all, { desc = 'Delete all buffers' })

			-- Debug print
			_G.dd = function(...) Snacks.debug.inspect(...) end ---@diagnostic disable-line
			_G.bt = function() Snacks.debug.backtrace() end ---@diagnostic disable-line

			vim.print = _G.dd -- Override print to use snacks for `:=` command
		end,
	},
})
