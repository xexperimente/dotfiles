vim.pack.add({ 'https://github.com/oribarilan/lensline.nvim' })

vim.defer_fn(
	function()
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
	end,
	80
)
