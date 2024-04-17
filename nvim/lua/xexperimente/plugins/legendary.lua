local Plugin = { 'mrjones2014/legendary.nvim' }

Plugin.priority = 10000

Plugin.lazy = false

Plugin.opts = {
	extensions = {
		lazy_nvim = true,
	},
	select_prompt = 'legendary.nvim',
	keymaps = {
		{ '<M-p>', '<cmd>Legendary<Cr>', description = 'Open command palette' },
	},
}

return Plugin
