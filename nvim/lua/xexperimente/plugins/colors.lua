vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local dawn = {
	base = '#faf4ed',
	surface = '#fffaf3',
	overlay = '#f2e9de',
	muted = '#9893a5',
	subtle = '#797593',
	text = '#575279',
	love = '#b4637a',
	gold = '#ea9d34',
	rose = '#d7827e',
	pine = '#286983',
	foam = '#56949f',
	iris = '#907aa9',
	highlight_hi = '#cecacd',
}

local moon = {
	base = '#232136',
	surface = '#2a273f',
	overlay = '#393552',
	muted = '#6e6a86',
	subtle = '#908caa',
	text = '#e0def4',
	love = '#eb6f92',
	gold = '#f6c177',
	rose = '#ea9a97',
	pine = '#3e8fb0',
	foam = '#9ccfd8',
	iris = '#c4a7e7',
	highlight_hi = '#56526e',
}

local _default = {
	base = '#191724',
	surface = '#1f1d2e',
	overlay = '#26233a',
	muted = '#6e6a86',
	subtle = '#908caa',
	text = '#e0def4',
	love = '#eb6f92',
	gold = '#f6c177',
	rose = '#ebbcba',
	pine = '#31748f',
	foam = '#9ccfd8',
	iris = '#c4a7e7',
	highlight_hi = '#524f67',
}

--- @diagnostic disable-next-line: undefined-field
local colors = vim.opt.background:get() == 'dark' and moon or dawn

local palette = {
	base00 = colors.base,
	base01 = colors.surface,
	base02 = colors.overlay,
	base03 = colors.muted,
	base04 = colors.subtle,
	base05 = colors.text,
	base06 = colors.text,
	base07 = colors.highlight_hi,
	base08 = colors.love,
	base09 = colors.gold,
	base0A = colors.rose,
	base0B = colors.pine,
	base0C = colors.foam,
	base0D = colors.iris,
	base0E = colors.gold,
	base0F = colors.highlight_hi,
}

require('mini.base16').setup({ palette = palette, use_cterm = false })

local hl = vim.api.nvim_set_hl

-- Basics
hl(0, 'Whitespace', { fg = colors.overlay, bg = 'none' })
hl(0, 'CursorLineNr', { fg = colors.text, bg = 'none', bold = true })
hl(0, 'LineNr', { fg = colors.muted, bg = 'none' })
hl(0, 'LineNrAbove', { link = 'LineNr' })
hl(0, 'LineNrBelow', { link = 'LineNr' })
hl(0, 'FoldColumn', { fg = colors.muted, bg = 'none' })
hl(0, 'Folded', { bg = colors.base })
hl(0, 'Directory', { fg = colors.rose, bg = 'none' })
hl(0, 'MsgArea', { fg = colors.rose, bg = colors.base })
hl(0, 'MsgSeparator', { fg = colors.rose, bg = colors.base })
hl(0, 'WinSeparator', { fg = colors.overlay, bg = colors.base })
hl(0, 'IncSearch', { fg = colors.base, bg = colors.rose })
hl(0, 'CurSearch', { fg = colors.base, bg = colors.gold })

-- Syntax
hl(0, 'Keyword', { fg = colors.love })
hl(0, 'Identifier', { fg = colors.text })
hl(0, 'String', { fg = colors.gold })
hl(0, 'Number', { fg = colors.love })
-- hl(0, '@variable', { fg = colors.text })
-- hl(0, '@property', { fg = colors.rose })

-- Whitespace
hl(0, 'VisualNonText', { fg = colors.highlight_hi, bg = colors.overlay })

-- Statusline
hl(0, 'StatusLine', { fg = colors.muted, bg = colors.base })
hl(0, 'StatusLineActive', { fg = colors.rose, bg = colors.base })
hl(0, 'StatusLineDim', { fg = colors.subtle, bg = colors.base })
hl(0, 'StatusLineHighlight', { fg = colors.gold, bg = colors.base })

-- Menus
hl(0, 'PmenuSel', { bg = colors.overlay, fg = 'none' })
hl(0, 'Pmenu', { fg = colors.subtle, bg = colors.overlay })

-- Diffs
hl(0, 'DiffDelete', { fg = colors.overlay, bg = colors.base })
hl(0, 'CodeDiffFiller', { link = 'DiffDelete' })

-- Blink.cmp
hl(0, 'BlinkCmpMenu', { fg = colors.subtle, bg = colors.base })
hl(0, 'BlinkCmpMenuBorder', { fg = colors.highlight_hi, bg = colors.base })
hl(0, 'BlinkCmpMenuSelection', { fg = colors.overlay, bg = colors.rose })
hl(0, 'BlinkCmpLabelDetail', { fg = colors.rose, bg = colors.base })
hl(0, 'BlinkCmpScrollBarThumb', { bg = colors.overlay })
hl(0, 'BlinkCmpDoc', { bg = colors.base })
hl(0, 'BlinkCmpDocBorder', { fg = colors.highlight_hi, bg = colors.base })
hl(0, 'BlinkCmpSignatureHelp', { bg = colors.base })
hl(0, 'BlinkCmpSignatureHelpBorder', { fg = colors.highlight_hi, bg = colors.base })
hl(0, 'BlinkCmpSignatureHelpActiveParameter', { fg = colors.base, bg = colors.rose })

-- Flash
hl(0, 'FlashLabel', { fg = colors.surface, bg = colors.highlight_hi })

-- Floats
hl(0, 'FloatBorder', { fg = colors.overlay, bg = colors.surface })
hl(0, 'FloatTitle', { bg = colors.rose, fg = colors.overlay })
hl(0, 'Border', { fg = colors.overlay, bg = colors.base })

-- Snacks
hl(0, 'SnacksDashboardHeader', { fg = colors.rose, bg = colors.base })
hl(0, 'SnacksDashboardDesc', { fg = colors.rose, bg = colors.base })
hl(0, 'SnacksDashboardFile', { fg = colors.rose, bg = colors.base })
hl(0, 'SnacksInputTitle', { link = 'FloatTitle' })
hl(0, 'SnacksInputPrompt', { fg = colors.rose, bg = colors.surface })
hl(0, 'SnacksPickerPrompt', { fg = colors.rose, bg = colors.surface })
hl(0, 'SnacksPickerTree', { fg = colors.highlight_hi, bg = colors.surface })
hl(0, 'SnacksFooterKey', { bg = colors.love, fg = colors.surface })
hl(0, 'SnacksFooterDesc', { link = 'FloatTitle' })

-- Treesitter Context
hl(0, 'TreesitterContext', { bg = colors.base })
hl(0, 'TreesitterContextLineNumber', { bg = colors.base, fg = colors.muted })
hl(0, 'TreesitterContextSeparator', { fg = colors.overlay, bg = colors.base })

-- Mini
hl(0, 'MiniDiffSignChange', { bg = colors.base, fg = colors.gold })
hl(0, 'MiniDiffSignAdd', { bg = colors.base, fg = colors.foam })
hl(0, 'MiniDiffSignDelete', { bg = colors.base, fg = colors.love })
hl(0, 'MiniPickBorderText', { link = 'FloatTitle' })
hl(0, 'MiniClueTitle', { link = 'FloatTitle' })
hl(0, 'MiniIconsRed', { fg = colors.love })
hl(0, 'MiniIconsGrey', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsAzure', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsPurple', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsBlue', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsGreen', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsYellow', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsCyan', { link = 'MiniIconsRed' })
hl(0, 'MiniIconsOrange', { link = 'MiniIconsRed' })

-- Peekstack
hl(0, 'PeekstackPopupBorderFocused', { fg = colors.highlight_hi, bg = colors.surface })
hl(0, 'PeekstackTitlePath', { link = 'FloatTitle' })
hl(0, 'PeekstackTitleLine', { bg = colors.rose, fg = colors.gold })
hl(0, 'PeekstackStack', { bg = colors.base })

-- Mason
hl(0, 'MasonHeader', { link = 'FloatTitle' })

-- markdown/vimdoc
hl(0, '@markup.link.vimdoc', { bg = colors.gold, fg = colors.surface })
hl(0, '@markup.heading.1.vimdoc', { bg = 'none', fg = colors.gold })
hl(0, '@markup.heading.1.delimiter.vimdoc', { bg = 'none', fg = colors.rose })

-- vim.pack.add({
-- 	{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
-- })
--
-- require('rose-pine').setup({
-- 	enable = {
-- 		legacy_highlights = false,
-- 		migrations = false,
-- 	},
-- 	highlight_groups = {
-- 		Whitespace = { bg = 'NONE', fg = 'overlay' },
-- 		IncSearch = { fg = 'base', bg = 'rose', inherit = false },
-- 		CurSearch = { fg = 'base', bg = 'gold', inherit = false },
-- 		Search = { fg = 'text', bg = 'rose', blend = 20, inherit = false },
-- 		Keyword = { fg = 'rose' },
-- 		Folded = { bg = 'base' },
-- 		Comment = { fg = 'muted' },
-- 		WinSeparator = { fg = 'overlay', bg = 'none' },
-- 		MsgSeparator = { fg = 'rose', bg = 'none' },
-- 		Directory = { fg = 'rose', bg = 'none' },
--
-- 		-- Diffs
-- 		DiffDelete = { fg = 'overlay', bg = 'base' },
-- 		CodeDiffFiller = { link = 'DiffDelete' },
--
-- 		-- Statusline
-- 		StatusLineActive = { fg = 'rose', bg = 'none' },
-- 		StatusLineDim = { fg = 'subtle', bg = 'none' },
-- 		StatusLineHighlight = { fg = 'gold', bg = 'none' },
-- 		StatusLine = { bg = 'NONE', fg = 'highlight_high' },
-- 		StatusLineTerm = { bg = 'NONE', fg = 'highlight_high' },
-- 		StatusLineTermNC = { bg = 'NONE', fg = 'highlight_high' },
--
-- 		-- Floats
-- 		FloatBorder = { fg = 'overlay', bg = 'surface' },
-- 		FloatTitle = { bg = 'rose', fg = 'overlay', blend = 70 },
-- 		PeekstackPopupBorderFocused = { fg = 'highlight_med', bg = 'surface' },
-- 		PeekstackTitlePath = { link = 'FloatTitle' },
-- 		PeekstackTitleLine = { bg = 'rose', fg = 'gold' },
--
-- 		-- Mini
-- 		MiniDiffSignChange = { bg = 'none', fg = 'Gold' },
-- 		MiniPickBorderText = { link = 'FloatTitle' },
-- 		MiniClueTitle = { link = 'FloatTitle' },
--
-- 		-- Snacks.nvim
-- 		SnacksNotifierHistory = { bg = 'surface' },
-- 		SnacksPickerTitle = { link = 'MiniPickBorderText' },
-- 		SnacksPickerDirectory = { fg = 'rose' },
-- 		SnacksScratchKey = { bg = 'rose', fg = 'surface' },
-- 		SnacksScratchDesc = { link = 'SnacksPickerTitle' },
-- 		SnacksDashboardIcon = { fg = 'iris' },
-- 		SnacksDashboardFile = { fg = 'rose' },
-- 		SnacksDashboardSpecial = { fg = 'rose' },
-- 		SnacksDashboardDesc = { fg = 'rose' },
-- 		SnacksDashboardTitle = { fg = 'love' },
-- 		SnacksDashboardHeader = { fg = 'rose' },
-- 		SnacksDashboardFooter = { fg = 'iris' },
-- 		SnacksNotifierBorderInfo = { fg = 'overlay', bg = 'none' },
-- 		SnacksNotifierTitleInfo = { fg = 'iris', bg = 'none' },
-- 		SnacksInputTitle = { link = 'FloatTitle' },
--
-- 		-- TS Context
-- 		TreesitterContext = { bg = 'base' },
-- 		TreesitterContextLineNumber = { bg = 'base', fg = 'muted' },
-- 		TreesitterContextSeparator = { fg = 'overlay', bg = 'base' },
--
-- 		-- Menus
-- 		PmenuSel = { bg = 'highlight_med', fg = 'NONE' },
-- 		Pmenu = { fg = 'subtle', bg = 'surface' },
--
-- 		-- Blink.cmp
-- 		BlinkCmpMenu = { fg = 'subtle', bg = 'base' },
-- 		BlinkCmpMenuBorder = { fg = 'overlay', bg = 'base' },
-- 		BlinkCmpLabelDetail = { fg = 'rose', bg = 'base' },
--
-- 		MatchParen = { bg = 'highlight_med' },
-- 		LspReferenceText = { bg = 'rose', blend = 15 },
--
-- 		-- markdown/vimdoc
-- 		['@markup.link.vimdoc'] = { bg = 'gold', fg = 'base' },
-- 		['@markup.heading.1.vimdoc'] = { bg = 'none', fg = 'gold' },
-- 		RenderMarkdownCodeInline = { bg = 'overlay', fg = 'text' },
-- 		RenderMarkdownCodeInfo = { bg = 'rose', blend = 50, fg = 'text' },
-- 		RenderMarkdownInlineHighlight = { bg = 'gold', blend = 50, fg = 'base' },
--
-- 		-- Semantic tokens
-- 		Structure = { fg = 'rose' },
-- 		['@property'] = { fg = 'iris', italic = false },
-- 		-- ['@variable'] = { fg = 'iris', italic = false },
-- 		-- ['@lsp.type.variable'] = { fg = 'text', italic = false },
-- 		-- ['@lsp.type.property'] = { fg = 'text', italic = false }, -- iris
-- 		-- ['@lsp.mod.static'] = { fg = 'iris' },
-- 	},
-- })
--
-- function set_theme(light)
-- 	if light then
-- 		vim.cmd('colorscheme rose-pine-dawn')
-- 	else
-- 		vim.cmd('colorscheme rose-pine-moon')
-- 	end
-- end
--
-- ---@diagnostic disable:undefined-field
-- local dark = function() return vim.opt.background:get() == 'dark' end
--
-- set_theme(not dark())
--
-- vim.keymap.set('n', '<leader>ub', function() set_theme(dark()) end, { desc = 'Toggle background' })
