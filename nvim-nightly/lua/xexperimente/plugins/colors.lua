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
			FloatBorder = { fg = 'bg3', bg = 'bg2' },
			FloatTitle = { fg = 'bg0', bg = 'palette.red' },
			NormalFloat = { bg = 'bg2' },

			Statusline = { bg = '#0d1117' },
			StatuslineActive = { fg = 'palette.red', bg = 'bg1' },
			StatuslineDim = { fg = 'palette.blue', bg = 'bg1' },
			StatuslineHighlight = { fg = 'palette.yellow', bg = 'bg1' },

			Keyword = { fg = 'palette.red' },
		},
	},
})

---@diagnostic disable-next-line: undefined-field
if vim.opt.background:get() == 'light' then
	vim.cmd('colorscheme rose-pine-dawn')
else
	vim.cmd('colorscheme github_dark_default')
end
