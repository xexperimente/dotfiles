vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
	explorer = {
		replace_netrw = true,
	},
	notifier = {
		enabled = true,
		style = 'compact',
	},
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
			explorer = {
				tree = true,
				auto_close = true,
				layout = { preset = 'vertical', preview = false },
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
bind(
	'n',
	'<leader>ub',
	function() Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }) end,
	{}
)
bind('n', '<leader>uL', function() Snacks.toggle.option('relativenumber', { name = 'Relative Number' }) end, {})
bind('n', '<leader>us', function() Snacks.toggle.option('spell', { name = 'Spelling' }) end, {})
bind('n', '<leader>uw', function() Snacks.toggle.option('wrap', { name = 'Wrap' }) end, {})
bind('n', '<leader>ud', '<cmd>lua Snacks.toggle.diagnostics()<cr>', {})
bind('n', '<leader>ul', '<cmd>lua Snacks.toggle.line_number()<cr>', {})
bind('n', '<leader>uh', '<cmd>lua Snacks.toggle.inlay_hints()<cr>', {})
bind('n', '<leader>uD', '<cmd>lua Snacks.toggle.dim()<cr>', {})
bind('n', '<leader>uT', '<cmd>lua Snacks.toggle.treesitter()<cr>', {})
bind('n', '<leader>ug', '<cmd>lua Snacks.toggle.indent()<cr>', {})
bind('n', '<leader>pP', '<cmd>lua Snacks.toggle.profiler()<cr>', {})
bind('n', '<leader>ph', '<cmd> lua Snacks.toggle.profiler_highlights()<cr>', {})

-- Utils
bind('n', '<leader>bd', '<cmd>lua Snacks.bufdelete()<cr>', {})

-- Pickers
bind('n', '<leader>ff', '<cmd>lua Snacks.picker.files()<cr>', {})
bind('n', '<leader>fe', '<cmd>lua Snacks.explorer()<cr>', {})
bind('n', '<leader>fc', '<cmd>lua Snacks.picker.highlights()<cr>', {})
bind('n', '<leader>fh', '<cmd>lua Snacks.picker.help()<cr>', {})
bind('n', '<leader>fk', '<cmd>lua Snacks.picker.keymaps()<cr>', {})
bind('n', '<leader>fk', '<cmd>lua Snacks.picker.keymaps()<cr>', {})
bind('n', '<leader>fu', '<cmd>lua Snacks.picker.undo()<cr>', {})
bind('n', '<leader>fg', '<cmd>lua Snacks.picker.grep()<cr>', {})
bind('n', '<leader>fG', '<cmd>lua Snacks.picker.grep_word()<cr>', {})
bind('n', '<leader>fm', '<cmd>lua Snacks.picker.marks()<cr>', {})
bind('n', '<leader>fi', '<cmd>lua Snacks.picker.icons()<cr>', {})

-- Git
bind('n', '<leader>gl', '<cmd>lua Snacks.picker.git_log()<cr>', { desc = 'Git commits' })
bind('n', '<leader>gb', '<cmd>lua Snacks.picker.git_branches()<cr>', { desc = 'Git branches' })
bind('n', '<leader>gs', '<cmd>lua Snacks.picker.git_status()<cr>', { desc = 'Git status' })
bind('n', '<leader>gB', '<cmd>lua Snacks.git.blame_line()<cr>', { desc = 'Git Blame Line' })

-- Diagnostics
bind('n', '<leader>lp', '<cmd>lua Snacks.picker.diagnostics_buffer()<cr>', {})
bind('n', '<leader>lP', '<cmd>lua Snacks.picker.diagnostics()<cr>', {})

-- Terminal
bind('n', '<leader>t', '<cmd>lua Snacks.terminal.toggle()<cr>', {})
bind('n', '<c-t>', '<cmd>lua Snacks.terminal.toggle()<cr>', {})

-- Zen mode
bind('n', '<leader>z', '<cmd>lua Snacks.zen()<cr>', { desc = 'Toggle Zen Mode' })
bind('n', '<leader>Z', '<cmd>lua Snacks.zen.zoom()<cr>', { desc = 'Toggle Zoom' })

-- Notification history
bind('n', '<leader>n', '<cmd>lua Snacks.notifier.show_history()<cr>', { desc = 'Notification History' })
bind('n', '<leader>N', function()
	local lines = {}
	local messages = vim.api.nvim_exec2('messages', { output = true })

	for script in messages.output:gmatch('[\r\n]+') do
		table.insert(lines, script)
	end

	Snacks.win({
		text = lines,
		width = 0.8,
		height = 0.6,
		border = 'single',
		-- title = 'Messages',
		wo = {
			spell = false,
			wrap = false,
			signcolumn = 'yes',
			statuscolumn = ' ',
			conceallevel = 3,
		},
	}):set_title('Messages', 'center')
end, { desc = 'Show Messages' })

-- Scratch buffer
bind('n', '<leader>.', '<cmd>lua Snacks.scratch({ icon = "" })<cr>', { desc = 'Toggle Scratch Buffer' })
bind('n', '<leader>;', '<cmd>lua Snacks.scratch.select()<cr>', { desc = 'Select Scratch Buffer' })

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
