local Plugin = { 'mrjones2014/legendary.nvim' }

Plugin.priority = 10000

Plugin.lazy = false

Plugin.keys = {
	{ '<C-P>', '<cmd>Legendary<cr>' },
}

Plugin.opts = {
	extensions = {
		lazy_nvim = true,
	},
}

-- sqlite is only needed if you want to use frecency sorting
-- dependencies = { 'kkharji/sqlite.lua' }

return Plugin
