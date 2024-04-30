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

		LirFloatNormal = { bg = 'surface' },
		LirFloatCurdirWindowNormal = { bg = 'surface' },
		Keyword = { fg = 'love' },
		RainbowDelimiterRed = { fg = 'love' },
		Folded = { bg = 'base' },
	},
}

return Plugin
