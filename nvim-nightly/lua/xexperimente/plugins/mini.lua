-- local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = vim.version.range('*') } end
local function gh(pkg) return { src = 'https://github.com/' .. pkg } end

vim.pack.add({
	gh('nvim-mini/mini.nvim'),
})

vim.defer_fn(function()
	local opts = {
		patterns = {
			highlighters = {
				fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
				todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
				note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
				hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
			},
		},
		surround = { mappings = { update_n_lines = nil } },
		diff = { view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } } },
		indentscope = {
			draw = { animation = require('mini.indentscope').gen_animation.none() },
			symbol = '▎',
		},
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
	}

	local bind = vim.keymap.set

	require('mini.ai').setup()
	require('mini.diff').setup(opts.diff)
	require('mini.git').setup()
	require('mini.icons').setup()
	require('mini.move').setup(opts.move)
	require('mini.indentscope').setup(opts.indentscope)
	require('mini.splitjoin').setup()
	require('mini.surround').setup(opts.surround)
	require('mini.hipatterns').setup(opts.patterns)

	bind('n', '<leader>uj', '<cmd>lua MiniSplitjoin.toggle()<cr>', { desc = 'Toggle splitjoin' })
	bind('n', '<leader>gc', '<cmd>lua MiniDiff.toggle_overlay()<cr>', { desc = 'Show diff overlay' })
end, 80)
