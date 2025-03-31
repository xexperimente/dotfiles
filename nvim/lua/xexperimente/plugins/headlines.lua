local Plugin = { 'MeanderingProgrammer/render-markdown.nvim' }

Plugin.ft = 'markdown'

Plugin.opts = {
	code = {
		width = 'block',
		left_pad = 4,
		right_pad = 4,
		disable_background = false,
		style = 'normal',
		border = 'thick',
	},
	heading = {
		icons = function() return '' end,
	},
	latex = { enabled = false },
}

return Plugin

-- local Plugin = { 'lukas-reineke/headlines.nvim' }
--
-- Plugin.dependencies = 'nvim-treesitter/nvim-treesitter'
--
-- Plugin.ft = 'md'
--
-- Plugin.opts = {
-- 	markdown = {
-- 		fat_headlines = false,
-- 	},
-- }
--
-- return Plugin
