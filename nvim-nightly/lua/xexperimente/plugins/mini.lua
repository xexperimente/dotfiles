local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = vim.version.range('*') } end

vim.pack.add({
	gh('echasnovski/mini.ai'),
	gh('echasnovski/mini.diff'),
	gh('echasnovski/mini.hipatterns'),
	gh('echasnovski/mini.icons'),
	gh('echasnovski/mini.indentscope'),
	gh('echasnovski/mini.splitjoin'),
	gh('echasnovski/mini.surround'),
})

local lazy_load = vim.api.nvim_create_augroup('Plugins', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
	group = lazy_load,
	pattern = '*',
	callback = function()
		require('mini.ai').setup()
		require('mini.icons').setup()
		require('mini.indentscope').setup()
		require('mini.splitjoin').setup()
		require('mini.surround').setup()

		local patterns = require('mini.hipatterns')

		patterns.setup({
			highlighters = {
				fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
				todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
				note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
				hex_color = patterns.gen_highlighter.hex_color(),
			},
		})

		require('mini.diff').setup({
			view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } },
		})

		vim.api.nvim_clear_autocmds({ group = 'Plugins', event = 'BufReadPost' })
	end,
})
