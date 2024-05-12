local Plugin = { 'rose-pine/neovim' }

Plugin.name = 'rose-pine'

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	highlight_groups = {
		Whitespace = { bg = 'base', fg = 'overlay' },
		StatusLine = { bg = 'base', fg = 'text' },
		MiniCursorword = { bg = 'overlay' },

		-- CmpItemKindFunction = { fg = 'rose', bg = 'base' },
		-- CmpItemKindMethod = { link = 'CmpItemKindFunction' },
		-- CmpItemKindKeyword = { link = 'CmpItemKindFunction' },
		-- CmpItemKindText = { link = 'CmpItemKindFunction' },
		-- CmpItemKindField = { link = 'CmpItemKindFunction' },
		-- CmpItemKindVariable = { link = 'CmpItemKindFunction' },
		-- CmpItemKindEnum = { link = 'CmpItemKindFunction' },
		--
		-- CmpItemAbbrMatch = { fg = 'rose', bg = 'base' },
		--
		-- Pmenu = { fg = 'overlay', bg = 'base' },
		-- PmenuSel = { bg = 'surface', fg = 'NONE' },
		PmenuSel = { bg = 'surface', fg = 'NONE' },
		Pmenu = { fg = '#C5CDD9', bg = 'base' },

		CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
		CmpItemAbbrMatch = { fg = 'rose', bg = 'NONE', bold = true },
		CmpItemAbbrMatchFuzzy = { fg = 'rose', bg = 'NONE', bold = true },
		CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },
		CmpItemKind = { fg = 'rose', bg = 'none' },

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
