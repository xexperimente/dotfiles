vim.pack.add({ 'https://github.com/mhiro2/peekstack.nvim' })

vim.defer_fn(function()
	local ps = require('peekstack')
	local bind = vim.keymap.set

	ps.setup({
		ui = {
			title = {
				format = '{path}:{line}{context}',
				icons = { enabled = false },
			},
		},
	})

	bind('n', '<a-f12>', function() ps.peek.definition() end, { desc = 'Peek definition' })
end, 80)
