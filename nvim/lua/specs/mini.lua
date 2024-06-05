local Plugins = {}
local Plug = function(spec) table.insert(Plugins, spec) end

Plug({
	'echasnovski/mini.bufremove',
	version = false,
	main = 'mini.bufremove',
	lazy = true,
	event = 'VeryLazy',
	config = true,
	keys = { { '<leader>bd', '<cmd>lua pcall(MiniBufremove.delete)<cr>' } },
})

Plug({
	'echasnovski/mini.bracketed',
	version = false,
	main = 'mini.bracketed',
	lazy = true,
	event = 'VeryLazy',
	config = true,
})

-- surround selections
Plug({
	'echasnovski/mini.surround',
	version = false,
	lazy = true,
	config = true,
	keys = {
		'sa',
		'sd',
	},
})

-- Highlight all occurences of current word
Plug({
	'echasnovski/mini.cursorword',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.indentscope',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.splitjoin',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.notify',
	lazy = true,
	event = 'VeryLazy',
	version = false,
	opts = {
		lsp_progress = {
			enable = false,
		},
	},
	dependencies = { 'carbon-steel/detour.nvim' },
	init = function()
		vim.notify = function(...)
			local notify = require('mini.notify').make_notify()
			vim.notify = notify
			return notify(...)
		end

		vim.keymap.set('n', '<leader><space>', function()
			vim.cmd("echo ''")
			require('mini.notify').clear()
		end, { desc = 'Clear notifications' })

		vim.keymap.set('n', '<leader>o', function()
			require('detour').Detour()

			require('mini.notify').show_history()

			vim.keymap.set(
				'n',
				'<esc>',
				function()
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes('<c-w><c-q>', true, true, true),
						'n',
						true
					)
				end,
				{ desc = 'Close notify history', buffer = true }
			)

			vim.keymap.set(
				'n',
				'q',
				function()
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes('<c-w><c-q>', true, true, true),
						'n',
						true
					)
				end,
				{ desc = 'Close notify history', buffer = true }
			)
		end, { desc = 'Show notification history' })
	end,
})

local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		border = require('user.env').border,
		anchor = 'NW',
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

Plug({
	'echasnovski/mini.extra',
	version = false,
	main = 'mini.extra',
	lazy = false,
	config = true,
})

Plug({
	'echasnovski/mini.pick',
	version = false,
	main = 'mini.pick',
	lazy = true,
	opts = {
		window = {
			config = win_config,
			-- prompt_prefix = '> ',
		},
	},
	keys = {
		{ '<leader>fb', '<cmd>Pick buffers<cr>', { desc = 'Open buffers' } },
		{ '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Find files' } },
		{ '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' } },
		{ '<leader>fc', '<cmd>Pick hl_groups<cr>', { desc = 'Find colors' } },
		{ '<leader>fh', '<cmd>Pick help<cr>', { desc = 'Find in help' } },
		{ '<leader>fk', '<cmd>lua MiniExtra.pickers.keymaps()<cr>', { desc = 'Keymap' } },
		{ '<leader>fo', '<cmd>Pick oldfiles<cr>', { desc = 'Recent files' } },
		{ '<leader>fG', '<cmd>Pick grep<cr>', { desc = 'Grep string' } },
		{ '<leader>fs', '<cmd>Pick treesitter<cr>', { desc = 'Buffer symbols' } },
		{ '<leader>fr', '<cmd>Pick resume<cr>', { desc = 'Resume last search' } },
		{ '<leader>fm', '<cmd>Pick marks<cr>', { desc = 'Show marks' } },

		{ '<leader>fH', '<cmd>lua MiniExtra.pickers.history()<cr>', { desc = 'History' } },

		{ '<leader>gl', '<cmd>lua MiniExtra.pickers.git_commits()<cr>', { desc = 'Git commits' } },
		{
			'<leader>gb',
			'<cmd>lua MiniExtra.pickers.git_branches()<cr>',
			{ desc = 'Git branches' },
		},
	},
})

-- TODO: mini.sessions
-- TODO: mini.starter

return Plugins
