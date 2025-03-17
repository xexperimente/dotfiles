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
		SnacksPickerTitle = { link = 'MiniPickBorderText' },
		SnacksScratchKey = { bg = 'rose', fg = 'surface' },
		SnacksScratchDesc = { link = 'SnacksPickerTitle' },

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

		-- Floats
		FloatBorder = { fg = 'overlay', bg = 'surface' },
		FloatTitle = { link = 'MiniPickBorderText' },

		-- Lir
		LirFloatNormal = { bg = 'surface' },
		LirFloatCurdirWindowNormal = { bg = 'surface' },

		-- Basic
		Keyword = { fg = 'rose' },
		Folded = { bg = 'base' },
	},
}

return Plugin
