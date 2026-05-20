vim.schedule(function()
	vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })

	local opts = {
		ui = {
			border = vim.g.winborder,
			icons = require('icons').mason,
		},
	}

	require('mason').setup(opts)

	local bind = vim.keymap.set

	bind('n', '<leader>pm', '<cmd>Mason<cr>', { desc = 'Show mason' })
	bind('n', '<leader>pM', '<cmd>MasonUpdate<cr>', { desc = 'Update mason' })
end)
