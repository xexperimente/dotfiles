vim.pack.add({
	'https://github.com/folke/lazydev.nvim',
})

local opts = {
	library = {
		'luvit-meta/library',
		{ path = 'snacks.nvim', words = { 'Snacks' } },
		{ path = 'mini.nvim', words = { 'MiniStatusline', 'MiniClue' } },
		{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
	},
}

local lazy_load = vim.api.nvim_create_augroup('Plugins', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	group = lazy_load,
	pattern = 'lua',
	callback = function()
		require('lazydev').setup(opts)

		vim.api.nvim_clear_autocmds({ group = 'Plugins', event = 'FileType' })
	end,
})
