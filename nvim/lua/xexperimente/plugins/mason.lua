vim.schedule(function()
	vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })

	local opts = {
		ui = {
			border = vim.g.winborder,
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
		},
	}

	require('mason').setup(opts)
end)
