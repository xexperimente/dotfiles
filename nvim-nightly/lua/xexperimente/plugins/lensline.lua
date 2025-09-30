vim.pack.add({ 'https://github.com/oribarilan/lensline.nvim' })

require('lensline').setup({
	profiles = {
		{
			name = 'minimal',
			style = {
				placement = 'inline',
				prefix = '',
			},
		},
	},
})
