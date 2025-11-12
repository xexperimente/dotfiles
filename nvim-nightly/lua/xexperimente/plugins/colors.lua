vim.pack.add({
	{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
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
		DiffDelete = { fg = 'overlay', bg = 'base' },

		StatusLineActive = { fg = 'rose', bg = 'none' },
		StatusLineDim = { fg = 'subtle', bg = 'none' },
		StatusLineHighlight = { fg = 'gold', bg = 'none' },

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
		NoiceCmdlineIcon = { fg = 'overlay' },
		NoiceCmdlinePopup = { link = 'NormalFloat' },
		NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
		NoiceCmdlinePopupBorderSearch = { link = 'FloatBorder' },
		NoiceCmdlinePopupTitleCmdline = { link = 'FloatTitle' },
		NoiceCmdlinePopupTitleSearch = { link = 'FloatTitle' },
		NoiceCmdlinePrompt = { link = 'NormalFloat' },

		-- Snacks.nvim
		SnacksNotifierHistory = { bg = 'surface' },
		SnacksPickerTitle = { link = 'MiniPickBorderText' },
		SnacksPickerDirectory = { fg = 'rose' },
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
		SnacksInputTitle = { link = 'FloatTitle' },

		-- TS Context
		TreesitterContext = { bg = 'base' },
		TreesitterContextLineNumber = { bg = 'base', fg = 'muted' },
		TreesitterContextSeparator = { fg = 'overlay', bg = 'base' },
		-- Menus
		PmenuSel = { bg = 'highlight_med', fg = 'NONE' },
		Pmenu = { fg = 'overlay', bg = 'base' },

		MatchParen = { bg = 'highlight_med' },
		LspReferenceText = { bg = 'rose', blend = 15 },

		-- vimdoc
		['@markup.link.vimdoc'] = { bg = 'gold', fg = 'base' },
		['@markup.heading.1.vimdoc'] = { bg = 'none', fg = 'love' },
		['@label.vimdoc'] = { bg = 'none', fg = 'gold' },
		['@property'] = { fg = 'iris', italic = false },
		['@variable'] = { fg = 'iris', italic = false },
		['@lsp.type.variable'] = { fg = 'text', italic = false },
		['@lsp.type.property'] = { fg = 'text', italic = false }, -- iris
	},
})

function set_theme(light)
	if light then
		vim.cmd('colorscheme rose-pine-dawn')
	else
		vim.cmd('colorscheme rose-pine-moon')
	end
end

---@diagnostic disable:undefined-field
set_theme(vim.opt.background:get() == 'light')

vim.keymap.set(
	'n',
	'<leader>ub',
	function() set_theme(vim.opt.background:get() == 'dark') end,
	{ desc = 'Toggle background' }
)
