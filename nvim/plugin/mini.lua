vim.defer_fn(function()
	vim.pack.add({
		'https://github.com/nvim-mini/mini.ai',
		'https://github.com/nvim-mini/mini.bracketed',
		'https://github.com/nvim-mini/mini.cursorword',
		'https://github.com/nvim-mini/mini.diff',
		'https://github.com/nvim-mini/mini-git',
		'https://github.com/nvim-mini/mini.icons',
		'https://github.com/nvim-mini/mini.move',
		'https://github.com/nvim-mini/mini.splitjoin',
		'https://github.com/nvim-mini/mini.surround',
		'https://github.com/nvim-mini/mini.hipatterns',
	})

	local opts = {
		patterns = {
			highlighters = {
				fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
				todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
				note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
			},
		},
		surround = {
			mappings = {
				add = 'gsa', -- Add surrounding in Normal and Visual modes
				delete = 'gsd', -- Delete surrounding
				find = 'gsf', -- Find surrounding (to the right)
				find_left = 'gsF', -- Find surrounding (to the left)
				highlight = 'gsh', -- Highlight surrounding
				replace = 'gsr', -- Replace surrounding
				update_n_lines = nil, -- 'gsn'
			},
		},
		diff = { view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } } },
		move = {
			mappings = {
				left = '<M-left>',
				right = '<M-right>',
				up = '<M-up>',
				down = '<M-down>',

				-- Move current line in Normal mode
				line_left = '<M-left>',
				line_right = '<M-right>',
				line_down = '<M-down>',
				line_up = '<M-up>',
			},
		},
		icons = {
			file = {
				['README.md'] = { glyph = '', hl = 'MiniIconsRed' },
			},
			extension = {
				md = { glyph = '', hl = 'MiniIconsRed' },
			},
		},
	}

	require('mini.ai').setup()
	require('mini.bracketed').setup()
	require('mini.cursorword').setup()
	require('mini.diff').setup(opts.diff)
	require('mini.git').setup()
	require('mini.icons').setup(opts.icons)
	require('mini.move').setup(opts.move)
	require('mini.splitjoin').setup()
	require('mini.surround').setup(opts.surround)
	require('mini.hipatterns').setup(opts.patterns)

	local bind = vim.keymap.set

	bind('n', '<leader>gc', '<cmd>lua MiniDiff.toggle_overlay()<cr>', { desc = 'Show diff overlay' })
	bind('n', '<leader>uj', '<cmd>lua MiniSplitjoin.toggle()<cr>', { desc = 'Toggle splitjoin' })
	bind('n', 'J', '<cmd>lua MiniSplitjoin.toggle()<cr>', { desc = 'Toggle splitjoin' })
end, 0)
