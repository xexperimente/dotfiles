local Plugin = { 'rose-pine/neovim' }

Plugin.name = 'rose-pine'

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	highlight_groups = {
		Whitespace = { bg = 'NONE', fg = 'overlay' },
		StatusLine = { bg = 'base', fg = 'text' },
		MiniCursorword = { bg = 'overlay' },
		Search = { bg = 'rose', blend = 50 },

		-- Statusline
		STTUSLINE_NORMAL_MODE = { fg = 'base', bg = '#5FB0FC' },
		STTUSLINE_INSERT_MODE = { fg = 'base', bg = '#98bb6c' },
		STTUSLINE_REPLACE_MODE = { fg = 'base', bg = '#e46846' },
		STTUSLINE_VISUAL_MODE = { fg = 'base', bg = '#ffa066' },
		STTUSLINE_TERMINAL_MODE = { fg = 'base', bg = '#e6c384' },

		STTUSLINE_DEFAULT = { fg = 'text', bg = 'none' },

		-- Visual Multi
		VM_Mono = { link = 'DiffText' },
		VM_Extend = { bg = 'rose', blend = 70 },
		VM_Cursor = { bg = 'love', blend = 90 },
		VM_Insert = { link = 'DiffText' },

		PmenuSel = { bg = 'surface', fg = 'NONE' },
		Pmenu = { fg = 'overlay', bg = 'base' }, -- #c5cdd9

		-- Cmp
		CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
		CmpItemAbbrMatch = { fg = 'rose', bg = 'NONE', bold = true },
		CmpItemAbbrMatchFuzzy = { fg = 'rose', bg = 'NONE', bold = true },
		CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },
		CmpItemKind = { fg = 'rose', bg = 'none' },

		-- Floats
		FloatBorder = { fg = 'overlay', bg = 'surface' },
		LspInfoBorder = { link = 'FloatBorder' },

		TelescopePromptTitle = { fg = 'overlay', bg = 'rose' },
		TelescopeSelection = { bg = 'base', fg = 'text' },

		-- NvimTreeSpecialFile = { fg = 'muted', link = 'NvimTreeLineNR' },

		-- Lir
		LirFloatNormal = { bg = 'surface' },
		LirFloatCurdirWindowNormal = { bg = 'surface' },

		Keyword = { fg = 'rose' },

		RainbowDelimiterRed = { fg = 'love' },

		Folded = { bg = 'base' },
	},
}

return Plugin
