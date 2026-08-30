vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/nemanjamalesija/smart-paste.nvim' })

	require('smart-paste').setup({})
end, 0)
