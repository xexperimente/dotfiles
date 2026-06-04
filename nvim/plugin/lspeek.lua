vim.schedule(function()
	vim.pack.add({ 'https://github.com/r4ppz/lspeek.nvim' })

	local opts = {
		window = {
			width = 70,
			height = 15,
			border = 'single',
		},
		stack_limit = 7,
		select_first = false,
		keymaps = {
			close = 'q',
			split = 's',
			vsplit = 'v',
			enter = '<CR>',
		},
	}

	local ps = require('lspeek')

	ps.setup(opts)

	local bind = vim.keymap.set

	bind('n', '<a-f12>', ps.peek_definition, { desc = 'Peek definition' })
	bind('n', '<c-f12>', ps.peek_type_definition, { desc = 'Peek type definition' })
end)
