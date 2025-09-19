vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
	styles = {
		notification_history = {
			border = 'single',
			width = 0.8,
			keys = {
				['<Esc>'] = 'close',
			},
		},
		scratch = {
			border = 'single',
			keys = {
				['<Esc>'] = 'close',
			},
		},
		input = {
			row = 36,
			wo = {
				winhighlight = 'FloatBorder:FloatBorder',
			},
			border = 'rounded',
		},
	},
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	input = { enabled = true },
	explorer = { replace_netrw = true },
	notifier = { enabled = true, style = 'compact' },
	words = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
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
	scratch = {
		icon = '',
		win = {
			border = 'single',
			wo = { winhighlight = 'NormalFloat:NormalFloat' },
		},
	},
	terminal = {
		win = {
			position = 'float',
			border = 'single',
			keys = {
				term_hide = {
					'<c-t>',
					function(self) self:hide() end,
					mode = 't',
					expr = true,
				},
			},
			wo = {
				winbar = '',
				statusline = '',
			},
		},
		interactive = true,
	},
	picker = {
		sources = {
			files = {
				layout = {
					preview = false,
					layout = {
						-- backdrop = false,
						width = 0.5,
						min_width = 80,
						height = 0.7,
						min_height = 10,
						box = 'vertical',
						border = 'rounded',
						title = ' Files ',
						title_pos = 'center',
						{ win = 'input', height = 1, border = 'bottom' },
						{ win = 'list', border = 'none' },
						{ win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
					},
				},
				exclude = { 'zig-out/', 'node_modules', 'vendor' },
			},
			explorer = {
				tree = true,
				auto_close = true,
				layout = { preset = 'vertical', preview = false, layout = { backdrop = 60 } },
			},
			icons = {
				layout = 'select',
			},
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
			pickers = {
				preview = false,
				layout = 'select',
			},
			help = {
				preview = false,
				layout = 'select',
			},
			keymaps = {
				layout = {
					preview = false,
				},
			},
			qflist = {
				layout = 'vertical',
			},
			loclist = {
				layout = 'vertical',
			},
		},
	},
	dashboard = {
		width = 80,
		preset = {
			header = require('xexperimente.utils.dashboard'),
			keys = {
				{ icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = ' ', key = 'r', desc = 'Recent Projects', action = ":lua Snacks.dashboard.pick('projects')" },
				{
					icon = ' ',
					key = 'c',
					desc = 'Config',
					action = function()
						local config = vim.fn.stdpath('config')
						local path = ''
						if type(config) == 'table' then
							path = config[1] or ''
						else
							path = config
						end
						vim.api.nvim_set_current_dir(path)
						Snacks.picker.files()
					end,
				},
				{ icon = ' ', key = 'p', desc = 'Update plugins', action = ':lua vim.pack.update()' },
				{ icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
			},
		},
		sections = {
			{
				section = 'header',
			},
			{
				section = 'recent_files',
				padding = 1,
				-- title = 'Recent files:',
				-- indent = 2,
			},
			{
				section = 'keys',
				gap = 0,
				padding = 1,
				-- title = 'Actions:',
				-- indent = 2,
			},
		},
		formats = {
			icon = function(_) return '' end,
			file = function(item, ctx)
				local fname = vim.fn.fnamemodify(item.file, ':~')
				fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
				if #fname > ctx.width then
					local dir = vim.fn.fnamemodify(fname, ':h')
					local file = vim.fn.fnamemodify(fname, ':t')
					--- @diagnostic disable-next-line: unnecessary-if
					if dir and file then
						file = file:sub(math.floor(-(ctx.width - #dir - 2)))
						fname = dir .. '\\…' .. file
					end
				end
				local dir, file = fname:match('^(.*)\\(.+)$')
				return dir and { { dir .. '\\', hl = 'SnacksPickerDir' }, { file, hl = 'SnacksDashboardFile' } }
					or { { fname, hl = 'SnacksDashboardFile' } }
			end,
		},
	},
})

-- Debug print
_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end
vim.print = _G.dd -- Override print to use snacks for `:=` command

-- Keymaps
local bind = vim.keymap.set

-- Toggle options
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.dim():map('<leader>uD')
Snacks.toggle.treesitter():map('<leader>uT')

-- Utils
bind('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete buffer' })
bind('n', '<leader>bD', function() Snacks.bufdelete.other() end, { desc = 'Delete other buffers' })

-- Pickers
bind('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Files' })
bind('n', '<leader>fe', function() Snacks.explorer() end, { desc = 'Explorer' })
bind('n', '<leader>fc', function() Snacks.picker.highlights() end, { desc = 'Highlight groups' })
bind('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
bind('n', '<leader>fh', function() Snacks.picker.help() end, { desc = 'Help' })
bind('n', '<leader>fk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
bind('n', '<leader>fu', function() Snacks.picker.undo() end, { desc = 'Undo' })
bind('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = 'Grep' })
bind('n', '<leader>fG', function() Snacks.picker.grep_word() end, { desc = 'Grep word' })
bind('n', '<leader>fm', function() Snacks.picker.marks() end, { desc = 'Marks' })
bind('n', '<leader>fi', function() Snacks.picker.icons() end, { desc = 'Icons' })
bind('n', '<leader>fq', function() Snacks.picker.qflist() end, { desc = 'Quickfix list' })
bind('n', '<leader>fl', function() Snacks.picker.loclist() end, { desc = 'Location list' })

-- Git
bind('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git commits' })
bind('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git branches' })
bind('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git status' })
bind('n', '<leader>gB', function() Snacks.git.blame_line({ count = 1 }) end, { desc = 'Git Blame Line' })

-- Diagnostics
bind('n', '<leader>lp', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Show buffer diagnostics' })
bind('n', '<leader>lP', function() Snacks.picker.diagnostics() end, { desc = 'Show all diagnostics' })

-- Terminal
bind('n', '<leader>t', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })
bind('n', '<c-t>', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })

-- Zen mode
bind('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
bind('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })

-- Notification history
bind('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Show Notification History' })
bind('n', '<leader>m', function()
	local messages = vim.api.nvim_exec2('messages', { output = true })

	Snacks.win({
		text = messages.output,
		width = 0.8,
		height = 0.6,
		border = 'single',
		wo = {
			spell = false,
			wrap = false,
			signcolumn = 'yes',
			statuscolumn = ' ',
			conceallevel = 3,
		},
		keys = {
			['<Esc>'] = 'close',
		},
	}):set_title('Messages', 'center')
end, { desc = 'Show Messages' })

bind(
	'n',
	'<leader>i',
	function()
		Snacks.win({
			file = vim.api.nvim_get_runtime_file('doc/news.txt', true)[1],
			width = 0.6,
			height = 0.6,
			border = 'single',
			wo = {
				spell = false,
				wrap = false,
				signcolumn = 'yes',
				statuscolumn = ' ',
				conceallevel = 3,
			},
			keys = {
				['<Esc>'] = 'close',
			},
		})
	end,
	{ desc = 'Show Neovim News' }
)

-- Scratch buffer
bind('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
bind('n', '<leader>;', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })

-- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
vim.api.nvim_create_autocmd('LspProgress', {
	callback = function(ev)
		local spinner = { '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥' }

		vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
			id = 'lsp_progress',
			title = 'LSP Progress',
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == 'end' and ' '
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
