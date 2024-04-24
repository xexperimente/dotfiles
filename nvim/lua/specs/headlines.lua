local Plugin = { 'lukas-reineke/headlines.nvim' }

Plugin.dependencies = 'nvim-treesitter/nvim-treesitter'

Plugin.ft = 'md'

Plugin.opts = {
	markdown = {
		fat_headlines = false,
	},
}

return Plugin
