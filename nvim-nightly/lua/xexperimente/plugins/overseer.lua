vim.pack.add({
	'https://github.com/stevearc/overseer.nvim',
})

require('overseer').setup({
	log_level = vim.log.levels.DEBUG,
})
