vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/gbprod/yanky.nvim' })

	require('yanky').setup({
		ring = { history_length = 20 },
		highlight = { timer = 250 },
	})

	local bind = vim.keymap.set

	bind({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put yanked text after cursor' })
	bind({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put yanked text before cursor' })
	bind('n', '=p', '<Plug>(YankyPutAfterLinewise)', { desc = 'Put yanked text in line below' })
	bind('n', '=P', '<Plug>(YankyPutBeforeLinewise)', { desc = 'Put yanked text in line above' })
	bind('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle forward through yank history' })
	bind('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle backward through yank history' })
	bind({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yanky yank' })
end, 0)
