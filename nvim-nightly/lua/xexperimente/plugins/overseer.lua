vim.pack.add({
	'https://github.com/stevearc/overseer.nvim',
})

vim.defer_fn(function()
	require('overseer').setup({
		-- log_level = vim.log.levels.DEBUG,
		dap = false,
	})

	local bind = vim.keymap.set

	bind('n', '<Leader>o', '<cmd>OverseerRun<cr>')
	bind('n', '<Leader>O', '<cmd>OverseerToggle<cr>')
end, 60)
