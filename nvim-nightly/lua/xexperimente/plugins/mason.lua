vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })

local opts = {
	ui = {
		border = 'single',
	},
}

require('mason').setup(opts)
