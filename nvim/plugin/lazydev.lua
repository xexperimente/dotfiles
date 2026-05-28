vim.pack.add({ 'https://github.com/folke/lazydev.nvim' }, { load = false })

-- Load the plugin for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'lua' },
	callback = function()
		vim.cmd('packadd lazydev')
		require('lazydev').setup()
	end,
})
