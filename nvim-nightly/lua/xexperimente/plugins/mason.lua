vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })

vim.defer_fn(function()
	local opts = {
		ui = {
			border = vim.g.winborder,
		},
	}

	require('mason').setup(opts)
end, 80)
