local Plugin = { 'rose-pine/neovim' }

Plugin.name = 'rose-pine'

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	variant = 'auto',
	dark_variant = 'moon',
	styles = {
		transparency = false,
	},
	highlight_groups = {
		Whitespace = { bg = 'NONE', fg = 'overlay' },
		StatusLine = { bg = 'NONE', fg = 'highlight_high' },
		CurSearch = { fg = 'base', bg = 'rose', inherit = false },
		Search = { fg = 'text', bg = 'rose', blend = 20, inherit = false },
		Keyword = { fg = 'rose' },
		Folded = { bg = 'base' },
		Comment = { fg = 'muted' },
		WinSeparator = { fg = 'overlay', bg = 'none' },

		-- Floats
		FloatBorder = { fg = 'overlay', bg = 'surface' },
		FloatTitle = { bg = 'rose', fg = 'overlay' },

		-- Mini.nvim
		-- MiniCursorword = { bg = 'overlay' },
		-- MiniPickPrompt = { bg = 'NONE', fg = 'rose' },
		MiniDiffSignChange = { bg = 'none', fg = 'Gold' },
		MiniPickBorderText = { link = 'FloatTitle' },
		MiniStatuslineFilename = { bg = 'none', fg = 'text' },
		MiniStatuslineDevinfo = { bg = 'none', fg = 'text' },
		MiniStatuslineModeNormal = { link = 'UserStatuslineNormalMode' },
		MiniStatuslineModeInsert = { link = 'UserStatuslineInsertMode' },
		MiniStatuslineModeReplace = { link = 'UserStatuslineReplaceMode' },
		MiniStatuslineModeVisual = { link = 'UserStatuslineVisualMode' },
		MiniStatuslineModeCommand = { link = 'UserStatuslineNormalMode' },
		MiniStatuslineModeOther = { link = 'UserStatuslineTerminalMode' },

		-- Snacks.nvim
		SnacksNotifierHistory = { bg = 'surface' },
		SnacksPickerTitle = { link = 'MiniPickBorderText' },
		SnacksScratchKey = { bg = 'rose', fg = 'surface' },
		SnacksScratchDesc = { link = 'SnacksPickerTitle' },
		SnacksDashboardIcon = { fg = 'iris' },
		SnacksDashboardFile = { fg = 'rose' },
		SnacksDashboardSpecial = { fg = 'rose' },
		SnacksDashboardDesc = { fg = 'rose' },
		SnacksDashboardTitle = { fg = 'love' },
		SnacksDashboardHeader = { fg = 'rose' },
		SnacksDashboardFooter = { fg = 'iris' },
		SnacksNotifierBorderInfo = { fg = 'overlay', bg = 'none' },
		SnacksNotifierTitleInfo = { fg = 'iris', bg = 'none' },

		--Noice
		NoiceCmdlineIconSearch = { fg = 'rose' },
		NoiceCmdlineIconCmdline = { fg = 'rose' },
		NoiceCmdlineIconHelp = { fg = 'rose' },
		NoiceCmdlinePopup = { link = 'NormalFloat' },
		NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
		NoiceCmdlinePopupBorderSearch = { link = 'FloatBorder' },
		NoiceCmdlinePopupTitleCmdline = { link = 'FloatTitle' },
		NoiceCmdlinePopupTitleSearch = { link = 'FloatTitle' },
		NoiceCmdlinePrompt = { link = 'NormalFloat' },

		-- Trouble
		TroubleNormal = { link = 'Normal' },
		TroubleNormalNC = { link = 'Normal' },

		-- Statusline
		UserStatuslineNormalMode = { fg = 'base', bg = '#5FB0FC' },
		UserStatuslineInsertMode = { fg = 'base', bg = '#98bb6c' },
		UserStatuslineReplaceMode = { fg = 'base', bg = '#e46846' },
		UserStatuslineVisualMode = { fg = 'base', bg = '#ffa066' },
		UserStatuslineTerminalMode = { fg = 'base', bg = '#e6c384' },
		UserStatuslineDefault = { fg = 'text', bg = 'NONE' },
		UserStatuslineBlock = { link = 'Statusline' },
		UserStatuslineHighlight1 = { link = 'WarningMsg' },
		UserStatuslineHighlight2 = { link = 'ErrorMsg' },

		-- Visual Multi
		VM_Mono = { link = 'DiffText' },
		VM_Extend = { bg = 'rose', blend = 70 },
		VM_Cursor = { bg = 'love', blend = 90 },
		VM_Insert = { link = 'DiffText' },

		-- Menus
		PmenuSel = { bg = 'highlight_med', fg = 'NONE' },
		Pmenu = { fg = 'overlay', bg = 'base' },

		-- Lir
		LirFloatNormal = { bg = 'surface' },
		LirFloatCurdirWindowNormal = { bg = 'surface' },

		-- vimdoc
		['@markup.link.vimdoc'] = { bg = 'gold', fg = 'base' },
		['@markup.heading.1.vimdoc'] = { bg = 'none', fg = 'love' },
		['@label.vimdoc'] = { bg = 'none', fg = 'gold' },
		['@property'] = { fg = 'iris', italic = false },
		['@lsp.type.variable'] = { fg = 'text', italic = false },
		['@lsp.type.property'] = { fg = 'iris', italic = false },
	},
}

return Plugin
