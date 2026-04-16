vim.pack.add({
	{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
})

require('rose-pine').setup({
	enable = {
		legacy_highlights = false,
		migrations = false,
	},
	highlight_groups = {
		Whitespace = { bg = 'NONE', fg = 'overlay' },
		IncSearch = { fg = 'base', bg = 'rose', inherit = false },
		CurSearch = { fg = 'base', bg = 'gold', inherit = false },
		Search = { fg = 'text', bg = 'rose', blend = 20, inherit = false },
		Keyword = { fg = 'rose' },
		Folded = { bg = 'base' },
		Comment = { fg = 'muted' },
		WinSeparator = { fg = 'overlay', bg = 'none' },
		MsgSeparator = { fg = 'rose', bg = 'none' },
		Directory = { fg = 'rose', bg = 'none' },

		-- Diffs
		DiffDelete = { fg = 'overlay', bg = 'base' },
		CodeDiffFiller = { link = 'DiffDelete' },

		-- Statusline
		StatusLineActive = { fg = 'rose', bg = 'none' },
		StatusLineDim = { fg = 'subtle', bg = 'none' },
		StatusLineHighlight = { fg = 'gold', bg = 'none' },
		StatusLine = { bg = 'NONE', fg = 'highlight_high' },
		StatusLineTerm = { bg = 'NONE', fg = 'highlight_high' },
		StatusLineTermNC = { bg = 'NONE', fg = 'highlight_high' },

		-- Floats
		FloatBorder = { fg = 'overlay', bg = 'surface' },
		FloatTitle = { bg = 'rose', fg = 'overlay', blend = 70 },
		PeekstackPopupBorderFocused = { fg = 'highlight_med', bg = 'surface' },
		PeekstackTitlePath = { link = 'FloatTitle' },
		PeekstackTitleLine = { bg = 'rose', fg = 'gold' },

		-- Mini
		MiniDiffSignChange = { bg = 'none', fg = 'Gold' },
		MiniPickBorderText = { link = 'FloatTitle' },
		MiniClueTitle = { link = 'FloatTitle' },

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
		Pmenu = { fg = 'subtle', bg = 'surface' },

		-- Blink.cmp
		BlinkCmpMenu = { fg = 'subtle', bg = 'base' },
		BlinkCmpMenuBorder = { fg = 'overlay', bg = 'base' },
		BlinkCmpLabelDetail = { fg = 'rose', bg = 'base' },

		MatchParen = { bg = 'highlight_med' },
		LspReferenceText = { bg = 'rose', blend = 15 },

		-- markdown/vimdoc
		['@markup.link.vimdoc'] = { bg = 'gold', fg = 'base' },
		['@markup.heading.1.vimdoc'] = { bg = 'none', fg = 'gold' },
		RenderMarkdownCodeInline = { bg = 'overlay', fg = 'text' },
		RenderMarkdownCodeInfo = { bg = 'rose', blend = 50, fg = 'text' },
		RenderMarkdownInlineHighlight = { bg = 'gold', blend = 50, fg = 'base' },

		-- Semantic tokens
		Structure = { fg = 'rose' },
		['@property'] = { fg = 'iris', italic = false },
		-- ['@variable'] = { fg = 'iris', italic = false },
		-- ['@lsp.type.variable'] = { fg = 'text', italic = false },
		-- ['@lsp.type.property'] = { fg = 'text', italic = false }, -- iris
		-- ['@lsp.mod.static'] = { fg = 'iris' },
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
local dark = function() return vim.opt.background:get() == 'dark' end

set_theme(not dark())

vim.keymap.set('n', '<leader>ub', function() set_theme(dark()) end, { desc = 'Toggle background' })
