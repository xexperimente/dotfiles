vim.schedule(function()
	vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })

	local opts = {
		ui = {
			border = vim.g.winborder,
		},
	}

	require('mason').setup(opts)
end)
