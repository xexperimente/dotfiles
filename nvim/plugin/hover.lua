vim.schedule(function()
	vim.pack.add({ 'https://github.com/lewis6991/hover.nvim' })

	require('hover').config({
		providers = {
			'hover.providers.lsp',
			'hover.providers.diagnostic',
			'hover.providers.dap',
			'hover.providers.dictionary',
		},
	})
	local bind = vim.keymap.set
	bind('n', 'K', function() require('hover').open() end, { desc = 'hover.nvim' })
	bind('n', 'gK', function() require('hover').enter() end, { desc = 'hover.nvim (enter)' })
end)
