local Plugin = { 'mrjones2014/legendary.nvim' }

Plugin.priority = 10000

Plugin.lazy = false

Plugin.opts = {
	extensions = {
		lazy_nvim = true,
	},
	keymaps = {
		{ '<leader>P', '<cmd>Legendary<Cr>', description = 'Open command palette' },
	},
}

return Plugin
