local Plugin = { 'rose-pine/neovim' }

Plugin.name = 'rose-pine'

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	highlight_groups = {
		Whitespace = { bg = 'base', fg = 'overlay' },
		StatusLine = { bg = 'base', fg = 'text' },
		MiniCursorword = { bg = 'overlay' },
		-- CmpItemKindFunction = { fg = 'base', bg = 'iris' },
		-- CmpItemKindMethod = { fg = 'base', bg = 'iris' },
		-- CmpItemKindKeyword = { fg = 'base', bg = 'subtle' },
		-- CmpItemKindText = { fg = 'base', bg = 'subtle' },
		-- CmpItemKindField = { fg = 'base', bg = 'love' },
		-- CmpItemKindVariable = { fg = 'base', bg = 'love' },
		-- CmpItemKindEnum = { fg = 'base', bg = 'foam' },
		CmpItemMenu = { fg = 'iris', italic = true },
		NvimTreeSpecialFile = { fg = 'muted', link = 'NvimTreeLineNR' },
		LspInfoBorder = { link = 'FloatBorder' },

		TelescopePromptNormal = { bg = 'overlay' },
		TelescopePromptBorder = { bg = 'overlay', fg = 'overlay' },
		TelescopeResultsNormal = { bg = 'surface' },
		TelescopeResultsBorder = { bg = 'surface', fg = 'surface' },
		TelescopePreviewNormal = { bg = 'surface' },
		TelescopePreviewBorder = { bg = 'surface', fg = 'surface' },

		TelescopePromptTitle = { fg = 'overlay', bg = 'rose' },
		TelescopePreviewTitle = { fg = 'overlay', bg = 'rose' },
		TelescopeResultsTitle = { fg = 'overlay', bg = 'rose' },
		TelescopeSelection = { bg = 'base', fg = 'text' },
	},
}

return Plugin
-- return {
--
-- 	-- Rose pine
-- 	{
-- 		'rose-pine/neovim',
-- 		lazy = false,
-- 		name = 'rose-pine',
-- 		opts = {
-- 			highlight_groups = {
-- 				Whitespace = { bg = 'base', fg = 'overlay' },
-- 				StatusLine = { bg = 'base', fg = 'text' },
-- 				MiniCursorword = { bg = 'overlay' },
-- 				CmpItemKindFunction = { fg = 'base', bg = 'iris' },
-- 				CmpItemKindMethod = { fg = 'base', bg = 'iris' },
-- 				CmpItemKindKeyword = { fg = 'base', bg = 'subtle' },
-- 				CmpItemKindText = { fg = 'base', bg = 'subtle' },
-- 				CmpItemMenu = { fg = 'iris', italic = true },
-- 			},
-- 		},
-- 	},
--
-- 	-- Tokyonight theme
-- 	{
-- 		'folke/tokyonight.nvim',
-- 		lazy = false,
-- 		opts = { style = 'moon' },
-- 	},
--
-- 	-- Github theme
-- 	{
-- 		'projekt0n/github-nvim-theme',
-- 		lazy = false,
-- 		opts = {
-- 			options = {
-- 				transparent = true,
-- 				styles = {
-- 					comments = 'italic',
-- 					types = 'italic',
-- 					functions = 'italic',
-- 				},
-- 			},
-- 			specs = {
-- 				github_dark_dimmed = {
-- 					diag = {
-- 						error = 'danger.muted',
-- 					},
-- 				},
-- 			},
-- 			groups = {
-- 				all = {
-- 					Whitespace = { fg = 'palette.border.default' },
-- 					StatusLine = { link = 'Normal' },
-- 				},
-- 			},
-- 		},
-- 		config = function(_, opts) require('github-theme').setup(opts or {}) end,
-- 	},
-- }
