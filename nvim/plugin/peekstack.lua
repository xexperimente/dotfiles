vim.schedule(function()
	vim.pack.add({ 'https://github.com/mhiro2/peekstack.nvim' })

	local ps = require('peekstack')

	ps.setup({
		ui = {
			title = {
				format = '{path}:{line}{context}',
				icons = { enabled = false },
			},
		},
	})

	local bind = vim.keymap.set

	bind('n', '<a-f12>', function() ps.peek.definition() end, { desc = 'Peek definition' })
	bind('n', '<s-f12>', function() ps.peek.references() end, { desc = 'Peek references' })
	bind('n', '<leader>up', '<cmd>PeekstackToggle<cr>', { desc = 'Toggle Peekstack' }) -- temporarily hide/show all popups in current stack
end)
