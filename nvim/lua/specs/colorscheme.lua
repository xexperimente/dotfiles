local Plugin = { 'rose-pine/neovim' }

Plugin.name = 'rose-pine'

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	highlight_groups = {
		Whitespace = { bg = 'NONE', fg = 'overlay' },
		StatusLine = { bg = 'NONE', fg = 'text' },
		Search = { bg = 'rose', blend = 50 },

		-- Snacks.nvim
		SnacksNotifierHistory = { bg = 'surface' },

		-- Mini.nvim
		MiniCursorword = { bg = 'overlay' },
		MiniDiffSignChange = { bg = 'none', fg = 'Gold' },
		MiniPickBorderText = { bg = 'rose', fg = 'overlay' },
		MiniPickPrompt = { bg = 'NONE', fg = 'rose' },
		MiniStatuslineFilename = { bg = 'none', fg = 'text' },
		MiniStatuslineDevinfo = { bg = 'none', fg = 'text' },
		MiniStatuslineModeNormal = { link = 'UserStatuslineNormalMode' },
		MiniStatuslineModeInsert = { link = 'UserStatuslineInsertMode' },
		MiniStatuslineModeReplace = { link = 'UserStatuslineReplaceMode' },
		MiniStatuslineModeVisual = { link = 'UserStatuslineVisualMode' },
		MiniStatuslineModeCommand = { link = 'UserStatuslineNormalMode' },
		MiniStatuslineModeOther = { link = 'UserStatuslineTerminalMode' },

		-- Statusline
		UserStatuslineNormalMode = { fg = 'base', bg = '#5FB0FC' },
		UserStatuslineInsertMode = { fg = 'base', bg = '#98bb6c' },
		UserStatuslineReplaceMode = { fg = 'base', bg = '#e46846' },
		UserStatuslineVisualMode = { fg = 'base', bg = '#ffa066' },
		UserStatuslineTerminal = { fg = 'base', bg = '#e6c384' },
		UserStatuslineDefault = { fg = 'text', bg = 'NONE' },
		UserStatuslineBlock = { link = 'Statusline' },
		UserStatuslineHighlight1 = { link = 'WarningMsg' },
		UserStatuslineHighlight2 = { link = 'ErrorMsg' },
		-- UserStatuslineNotice = { link = 'IncSearch' },

		-- Visual Multi
		VM_Mono = { link = 'DiffText' },
		VM_Extend = { bg = 'rose', blend = 70 },
		VM_Cursor = { bg = 'love', blend = 90 },
		VM_Insert = { link = 'DiffText' },

		PmenuSel = { bg = 'highlight_med', fg = 'NONE' }, -- bg surface / highlight_med
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
