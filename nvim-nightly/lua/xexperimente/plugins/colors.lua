vim.pack.add({
	{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
	{ src = 'https://github.com/projekt0n/github-nvim-theme', name = 'github-theme' },
})

require('rose-pine').setup({
	highlight_groups = {
		Whitespace = { bg = 'NONE', fg = 'overlay' },
		StatusLine = { bg = 'NONE', fg = 'highlight_high' },
		StatusLineTerm = { bg = 'NONE', fg = 'highlight_high' },
		StatusLineTermNC = { bg = 'NONE', fg = 'highlight_high' },
		CurSearch = { fg = 'base', bg = 'rose', inherit = false },
		Search = { fg = 'text', bg = 'rose', blend = 20, inherit = false },
		Keyword = { fg = 'rose' },
		Folded = { bg = 'base' },
		Comment = { fg = 'muted' },
		WinSeparator = { fg = 'overlay', bg = 'none' },
		Directory = { fg = 'rose', bg = 'none' },

		StatuslineActive = { fg = 'rose', bg = 'none' },
		StatuslineDim = { fg = 'muted', bg = 'none' },
		StatuslineHighlight = { fg = 'gold', bg = 'none' },

		-- Floats
		FloatBorder = { fg = 'overlay', bg = 'surface' },
		FloatTitle = { bg = 'rose', fg = 'overlay' },

		-- Mini
		MiniDiffSignChange = { bg = 'none', fg = 'Gold' },
		MiniPickBorderText = { link = 'FloatTitle' },
		MiniClueTitle = { link = 'FloatTitle' },

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

		-- Menus
		PmenuSel = { bg = 'highlight_med', fg = 'NONE' },
		Pmenu = { fg = 'overlay', bg = 'base' },

		-- vimdoc
		['@markup.link.vimdoc'] = { bg = 'gold', fg = 'base' },
		['@markup.heading.1.vimdoc'] = { bg = 'none', fg = 'love' },
		['@label.vimdoc'] = { bg = 'none', fg = 'gold' },
		['@property'] = { fg = 'iris', italic = false },
		['@lsp.type.variable'] = { fg = 'text', italic = false },
		['@lsp.type.property'] = { fg = 'iris', italic = false },
	},
})

require('github-theme').setup({
	options = {
		styles = {
			comments = 'italic',
		},
		transparent = true,
		hide_nc_statusline = true,
	},
	groups = {

		-- CurSearch = { fg = 'base', bg = 'rose', inherit = false },
		-- Search = { fg = 'text', bg = 'rose', blend = 20, inherit = false },
		-- Keyword = { fg = 'rose' },
		-- Folded = { bg = 'base' },
		-- Comment = { fg = 'muted' },
		-- WinSeparator = { fg = 'overlay', bg = 'none' },
		-- Directory = { fg = 'rose', bg = 'none' },
		--
		all = {
			-- Floats
			FloatBorder = { fg = 'bg3', bg = 'NONE' },
			FloatTitle = { fg = 'bg0', bg = 'palette.red' },
			NormalFloat = { bg = 'NONE' },

			Statusline = { bg = 'NONE' },
			StatuslineActive = { fg = 'palette.red', bg = 'NONE' },
			StatuslineDim = { fg = 'palette.blue', bg = 'NONE' },
			StatuslineHighlight = { fg = 'palette.yellow', bg = 'NONE' },

			Keyword = { fg = 'palette.red' },

			NoiceCmdlinePopup = { bg = 'NONE', fg = 'fg1' },
			NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
			NoiceCmdlinePopupTitle = { link = 'FloatTitle' },

			-- Snacks.nvim
			SnacksNotifierHistory = { bg = 'bg2' },
			SnacksPickerTitle = { link = 'FloatTitle' },
			SnacksScratchKey = { bg = 'palette.red', fg = 'bg0' },
			SnacksScratchDesc = { link = 'SnacksPickerTitle' },
		},
	},
})

if vim.opt.background:get() == 'light' then
	vim.cmd('colorscheme rose-pine-dawn')
else
	vim.cmd('colorscheme github_dark')
end
