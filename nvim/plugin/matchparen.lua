vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/monkoose/matchparen.nvim' })

	require('matchparen').setup({})
end, 0)
