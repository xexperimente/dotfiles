-- Reset highlighting.
vim.cmd.highlight('clear')
if vim.fn.exists('syntax_on') then vim.cmd.syntax('reset') end
vim.o.termguicolors = true
vim.g.colors_name = 'rosepine-dawn'

local colors = {
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
	highlight_med = '#dfdad9',
	highlight_low = '#f4ede8',
}

-- Terminal colors.
-- vim.g.terminal_color_0 = colors.base
-- vim.g.terminal_color_1 = colors.love
-- vim.g.terminal_color_2 = colors.foam
-- vim.g.terminal_color_3 = colors.gold
-- vim.g.terminal_color_4 = colors.iris
-- vim.g.terminal_color_5 = colors.rose
-- vim.g.terminal_color_6 = colors.pine
-- vim.g.terminal_color_7 = colors.white
-- vim.g.terminal_color_8 = colors.highlight_hi
-- vim.g.terminal_color_9 = colors.love
-- vim.g.terminal_color_10 = colors.pine
-- vim.g.terminal_color_11 = colors.gold
-- vim.g.terminal_color_12 = colors.pine
-- vim.g.terminal_color_13 = colors.iris
-- vim.g.terminal_color_14 = colors.foam
-- vim.g.terminal_color_15 = colors.surface
-- vim.g.terminal_color_background = colors.base
-- vim.g.terminal_color_foreground = colors.text

---@type table<string, vim.api.keyset.highlight>
local groups = {
	-- Builtins.
	Boolean = { fg = colors.pine },
	Border = { fg = colors.overlay, bg = colors.base },
	Character = { fg = colors.foam },
	ColorColumn = { bg = colors.highlight_hi },
	Comment = { fg = colors.muted, italic = true },
	Conceal = { fg = colors.muted },
	Conditional = { fg = colors.rose },
	Constant = { fg = colors.gold },
	CurSearch = { fg = colors.base, bg = colors.gold },
	Cursor = { fg = colors.surface, bg = colors.subtle },
	CursorColumn = { bg = colors.base },
	CursorLine = { bg = colors.highlight_hi },
	CursorLineNr = { fg = colors.text, bold = true },
	Define = { fg = colors.iris },
	Delimiter = { fg = colors.overlay },
	Directory = { fg = colors.rose },
	EndOfBuffer = { fg = colors.base },
	Error = { fg = colors.love },
	ErrorMsg = { fg = colors.love },
	FloatBorder = { fg = colors.overlay, bg = colors.surface },
	FloatTitle = { bg = colors.rose, fg = colors.overlay },
	FoldColumn = {},
	Folded = { bg = colors.base },
	Function = { fg = colors.gold },
	Identifier = { fg = colors.text },
	IncSearch = { fg = colors.base, bg = colors.rose },
	Include = { fg = colors.iris },
	Keyword = { fg = colors.rose },
	Label = { fg = colors.pine },
	LineNr = { fg = colors.muted },
	Macro = { fg = colors.iris },
	MatchParen = { sp = colors.text, underline = true },
	NonText = { fg = colors.muted },
	Normal = { fg = colors.text, bg = colors.base },
	NormalFloat = { fg = colors.text, bg = colors.surface },
	Number = { fg = colors.love },
	Pmenu = { fg = colors.text, bg = colors.base },
	PmenuSel = { fg = colors.base, bg = colors.rose },
	PmenuBorder = { fg = colors.highlight_hi, bg = colors.base },
	PmenuThumb = { bg = colors.highlight_hi },
	PreCondit = { fg = colors.pine },
	PreProc = { fg = colors.gold },
	Question = { fg = colors.iris },
	Repeat = { fg = colors.rose },
	Search = { fg = colors.base, bg = colors.rose },
	SignColumn = { bg = colors.base },
	Special = { fg = colors.foam, italic = true },
	SpecialComment = { fg = colors.muted, italic = true },
	SpecialKey = { fg = colors.subtle },
	SpellBad = { sp = colors.love, underline = true },
	SpellCap = { sp = colors.gold, underline = true },
	SpellLocal = { sp = colors.gold, underline = true },
	SpellRare = { sp = colors.gold, underline = true },
	Statement = { fg = colors.iris },
	StorageClass = { fg = colors.rose },
	Structure = { fg = colors.rose },
	Substitute = { fg = colors.love, bg = colors.gold, bold = true },
	Title = { fg = colors.rose },
	Todo = { fg = colors.iris, bold = true, italic = true },
	Type = { fg = colors.pine },
	TypeDef = { fg = colors.gold },
	Underlined = { fg = colors.pine, underline = true },
	VertSplit = { fg = colors.overlay },
	Visual = { bg = colors.highlight_hi },
	VisualNOS = { fg = colors.highlight_hi },
	VisualNonText = { fg = colors.overlay, bg = colors.highlight_hi },
	WarningMsg = { fg = colors.gold },
	WildMenu = { fg = colors.base, bg = colors.overlay },
	WinSeparator = { fg = colors.overlay, bg = colors.base },

	-- Treesitter.
	['@annotation'] = { fg = colors.gold },
	['@attribute'] = { fg = colors.pine },
	['@boolean'] = { fg = colors.iris },
	['@character'] = { fg = colors.foam },
	['@constant'] = { fg = colors.iris },
	['@constant.builtin'] = { fg = colors.iris },
	['@constant.macro'] = { fg = colors.pine },
	['@constructor'] = { fg = colors.pine },
	['@error'] = { fg = colors.love },
	['@function'] = { fg = colors.iris },
	['@function.builtin'] = { fg = colors.iris, italic = true },
	['@function.macro'] = { fg = colors.iris },
	['@function.method'] = { fg = colors.iris },
	['@keyword'] = { fg = colors.rose },
	['@keyword.conditional'] = { fg = colors.rose },
	['@keyword.exception'] = { fg = colors.iris },
	['@keyword.function'] = { fg = colors.pine },
	['@keyword.include'] = { fg = colors.rose },
	['@keyword.operator'] = { fg = colors.rose },
	['@keyword.repeat'] = { fg = colors.rose },
	['@label'] = { fg = colors.pine },
	['@markup'] = { fg = colors.gold },
	['@markup.emphasis'] = { fg = colors.gold, italic = true },
	['@markup.heading'] = { fg = colors.rose, bold = true },
	['@markup.link'] = { fg = colors.gold, bold = true },
	['@markup.link.uri'] = { fg = colors.gold, italic = true },
	['@markup.list'] = { fg = colors.pine },
	['@markup.raw'] = { fg = colors.rose },
	['@markup.strong'] = { fg = colors.gold, bold = true },
	['@markup.underline'] = { fg = colors.gold },
	['@module'] = { fg = colors.gold },
	['@number'] = { fg = colors.iris },
	['@number.float'] = { fg = colors.foam },
	['@operator'] = { fg = colors.rose },
	['@parameter.reference'] = { fg = colors.gold },
	['@property'] = { fg = colors.iris },
	['@punctuation.bracket'] = { fg = colors.text },
	['@punctuation.delimiter'] = { fg = colors.text },
	['@string'] = { fg = colors.gold },
	['@string.escape'] = { fg = colors.pine },
	['@string.regexp'] = { fg = colors.love },
	['@string.special.symbol'] = { fg = colors.iris },
	['@structure'] = { fg = colors.iris },
	['@tag'] = { fg = colors.pine },
	['@tag.attribute'] = { fg = colors.foam },
	['@tag.delimiter'] = { fg = colors.pine },
	['@type'] = { fg = colors.foam },
	['@type.builtin'] = { fg = colors.pine, italic = true },
	['@type.qualifier'] = { fg = colors.rose },
	['@variable'] = { fg = colors.text },
	['@variable.builtin'] = { fg = colors.iris },
	['@variable.member'] = { fg = colors.subtle },
	['@variable.parameter'] = { fg = colors.gold },

	-- Semantic tokens.
	['@class'] = { fg = colors.pine },
	['@decorator'] = { fg = colors.pine },
	['@enum'] = { fg = colors.pine },
	['@enumMember'] = { fg = colors.iris },
	['@event'] = { fg = colors.pine },
	['@interface'] = { fg = colors.pine },
	['@lsp.type.class'] = { fg = colors.pine },
	['@lsp.type.decorator'] = { fg = colors.foam },
	['@lsp.type.enum'] = { fg = colors.pine },
	['@lsp.type.enumMember'] = { fg = colors.iris },
	['@lsp.type.function'] = { fg = colors.iris },
	['@lsp.type.interface'] = { fg = colors.pine },
	['@lsp.type.macro'] = { fg = colors.pine },
	['@lsp.type.method'] = { fg = colors.text },
	['@lsp.type.namespace'] = { fg = colors.gold },
	['@lsp.type.parameter'] = { fg = colors.gold },
	['@lsp.type.property'] = { fg = colors.subtle },
	['@lsp.type.struct'] = { fg = colors.pine },
	['@lsp.type.type'] = { fg = colors.foam },
	['@lsp.type.variable'] = { fg = colors.text },
	['@modifier'] = { fg = colors.pine },
	['@regexp'] = { fg = colors.gold },
	['@struct'] = { fg = colors.pine },
	['@typeParameter'] = { fg = colors.pine },

	-- Statusline
	StatusLine = { fg = colors.muted, bg = colors.base },
	StatusLineActive = { fg = colors.rose, bg = colors.base },
	StatusLineDim = { fg = colors.subtle, bg = colors.base },
	StatusLineHighlight = { fg = colors.gold, bg = colors.base },

	-- LSP.
	ComplHint = { link = 'Comment' },
	DiagnosticDeprecated = { strikethrough = true, fg = colors.text },
	DiagnosticError = { fg = colors.love },
	DiagnosticHint = { fg = colors.iris },
	DiagnosticInfo = { fg = colors.pine },
	DiagnosticWarn = { fg = colors.gold },
	DiagnosticOk = { fg = colors.foam },
	DiagnosticFloatingError = { fg = colors.love },
	DiagnosticFloatingHint = { fg = colors.iris },
	DiagnosticFloatingInfo = { fg = colors.pine },
	DiagnosticFloatingWarn = { fg = colors.gold },
	DiagnosticUnderlineError = { undercurl = true, sp = colors.love },
	DiagnosticUnderlineHint = { undercurl = true, sp = colors.iris },
	DiagnosticUnderlineInfo = { undercurl = true, sp = colors.pine },
	DiagnosticUnderlineWarn = { undercurl = true, sp = colors.gold },
	DiagnosticUnnecessary = { fg = colors.subtle, italic = true },
	-- DiagnosticVirtualTextError = { fg = colors.base, bg = colors.rose },
	-- DiagnosticVirtualTextHint = { fg = colors.iris, bg = colors.transparent_blue },
	-- DiagnosticVirtualTextInfo = { fg = colors.pine, bg = colors.transparent_blue },
	-- DiagnosticVirtualTextWarn = { fg = colors.gold, bg = colors.transparent_yellow },
	LspCodeLens = { fg = colors.muted },
	LspInlayHint = { fg = colors.muted, italic = true },
	LspReferenceRead = {}, -- bg = colors.highlight_low
	LspReferenceText = {},
	LspReferenceWrite = { bg = colors.rose },
	LspSignatureActiveParameter = { bold = true, underline = true, sp = colors.text },

	-- Completions:
	-- BlinkCmpKindClass = { link = '@type' },
	-- BlinkCmpKindColor = { link = 'DevIconCss' },
	-- BlinkCmpKindConstant = { link = '@constant' },
	-- BlinkCmpKindConstructor = { link = '@type' },
	-- BlinkCmpKindEnum = { link = '@variable.member' },
	-- BlinkCmpKindEnumMember = { link = '@variable.member' },
	-- BlinkCmpKindEvent = { link = '@constant' },
	-- BlinkCmpKindField = { link = '@variable.member' },
	-- BlinkCmpKindFile = { link = 'Directory' },
	-- BlinkCmpKindFolder = { link = 'Directory' },
	-- BlinkCmpKindFunction = { link = '@function' },
	-- BlinkCmpKindInterface = { link = '@type' },
	-- BlinkCmpKindKeyword = { link = '@keyword' },
	-- BlinkCmpKindMethod = { link = '@function.method' },
	-- BlinkCmpKindModule = { link = '@module' },
	-- BlinkCmpKindOperator = { link = '@operator' },
	-- BlinkCmpKindProperty = { link = '@property' },
	-- BlinkCmpKindReference = { link = '@parameter.reference' },
	-- BlinkCmpKindStruct = { link = '@structure' },
	-- BlinkCmpKindText = { link = '@markup' },
	-- BlinkCmpKindTypeParameter = { link = '@variable.parameter' },
	-- BlinkCmpKindUnit = { link = '@variable.member' },
	-- BlinkCmpKindValue = { link = '@variable.member' },
	-- BlinkCmpKindVariable = { link = '@variable' },
	BlinkCmpKindSnippet = { link = '@markup' },
	BlinkCmpLabelDeprecated = { link = 'DiagnosticDeprecated' },
	BlinkCmpLabelDescription = { fg = colors.muted, italic = true },
	-- BlinkCmpLabelDetail = { fg = colors.subtle, bg = colors.base },
	-- BlinkCmpMenu = { bg = colors.base },
	-- BlinkCmpMenuBorder = { bg = colors.base },
	BlinkCmpMenu = { fg = colors.subtle, bg = colors.base },
	BlinkCmpKind = { fg = colors.rose },
	BlinkCmpLabel = { fg = colors.text },
	BlinkCmpLabelMatch = { fg = colors.love },
	BlinkCmpMenuBorder = { fg = colors.highlight_med, bg = colors.base },
	BlinkCmpMenuSelection = { fg = colors.overlay, bg = colors.rose },
	BlinkCmpLabelDetail = { fg = colors.rose, bg = colors.base },
	BlinkCmpScrollBarThumb = { bg = colors.overlay },
	BlinkCmpDoc = { bg = colors.base },
	BlinkCmpDocBorder = { fg = colors.highlight_med, bg = colors.base },
	BlinkCmpSignatureHelp = { bg = colors.overlay },
	BlinkCmpSignatureHelpBorder = { fg = colors.highlight_med, bg = colors.base },
	BlinkCmpSignatureHelpActiveParameter = { fg = colors.base, bg = colors.rose },

	-- Snacks
	SnacksDashboardHeader = { fg = colors.rose, bg = colors.base },
	SnacksDashboardDesc = { fg = colors.rose, bg = colors.base },
	SnacksDashboardFile = { fg = colors.rose, bg = colors.base },
	SnacksInputTitle = { link = 'FloatTitle' },
	SnacksInputPrompt = { fg = colors.rose, bg = colors.surface },
	SnacksPickerPrompt = { fg = colors.rose, bg = colors.surface },
	SnacksPickerTree = { fg = colors.highlight_hi, bg = colors.surface },
	SnacksFooterKey = { bg = colors.love, fg = colors.surface },
	SnacksFooterDesc = { link = 'FloatTitle' },

	-- Mini
	MiniDiffSignChange = { bg = colors.base, fg = colors.gold },
	MiniDiffSignAdd = { bg = colors.base, fg = colors.foam },
	MiniDiffSignDelete = { bg = colors.base, fg = colors.love },
	MiniPickBorderText = { link = 'FloatTitle' },
	MiniClueTitle = { link = 'FloatTitle' },
	MiniIconsRed = { fg = colors.love },
	MiniIconsGrey = { link = 'MiniIconsRed' },
	MiniIconsAzure = { link = 'MiniIconsRed' },
	MiniIconsPurple = { link = 'MiniIconsRed' },
	MiniIconsBlue = { link = 'MiniIconsRed' },
	MiniIconsGreen = { link = 'MiniIconsRed' },
	MiniIconsYellow = { link = 'MiniIconsRed' },
	MiniIconsCyan = { link = 'MiniIconsRed' },
	MiniIconsOrange = { link = 'MiniIconsRed' },
	MiniDiffOverAdd = { bg = '#dde4e0' },
	MiniDiffOverDelete = { bg = '#e4c3c6' },
	MiniDiffOverChange = { bg = '#f3ca91' },
	MiniDiffOverContext = { bg = '#f9e8cf' },
	MiniCursorword = { bg = colors.highlight_low },

	-- Dap UI.
	DapStoppedLine = { default = true, link = 'Visual' },
	NvimDapVirtualText = { fg = colors.rose, underline = true },

	-- Diffs.
	DiffAdd = { fg = colors.foam, bg = colors.base },
	DiffChange = { fg = colors.gold, bg = colors.base },
	DiffDelete = { fg = colors.rose, bg = colors.base },
	DiffText = { fg = colors.overlay, bg = colors.gold, bold = true },
	diffAdded = { fg = colors.foam, bold = true },
	diffChanged = { fg = colors.gold, bold = true },
	diffRemoved = { fg = colors.love, bold = true },
	CodeDiffFiller = { link = 'DiffDelete' },
	CodeDiffCharInsert = { bg = colors.foam },
	CodeDiffCharDelete = { bg = colors.rose },

	-- Command line.
	MoreMsg = { fg = colors.overlay, bold = true },
	MsgArea = { fg = colors.rose },
	MsgSeparator = { fg = colors.highlight_hi },

	-- Winbar styling.
	WinBar = { fg = colors.text, bg = colors.base },
	WinBarNC = { bg = colors.base },
	WinBarDir = { fg = colors.muted, bg = colors.base, italic = true },
	WinBarSeparator = { fg = colors.overlay, bg = colors.base },

	-- Quickfix window.
	QuickFixLine = { bg = colors.overlay, italic = true },

	-- When triggering flash, use a white font and make everything in the backdrop italic.
	FlashBackdrop = { italic = true },
	FlashPrompt = { link = 'Normal' },
	FlashLabel = { fg = colors.surface, bg = colors.highlight_hi },

	-- Treesitter Context
	TreesitterContext = { bg = colors.base },
	TreesitterContextLineNumber = { bg = colors.base, fg = colors.muted },
	TreesitterContextSeparator = { fg = colors.overlay, bg = colors.base },

	-- Peekstack
	PeekstackPopupBorderFocused = { fg = colors.highlight_hi, bg = colors.surface },
	PeekstackTitlePath = { link = 'FloatTitle' },
	PeekstackTitleLine = { bg = colors.rose, fg = colors.gold },
	PeekstackStack = { bg = colors.base },

	-- Render-Markdown
	RenderMarkdownCodeInline = { bg = colors.overlay },

	-- Mason
	MasonHeader = { link = 'FloatTitle' },

	--Hover.nvim
	HoverWindow = { bg = colors.base },
	HoverBorder = { bg = colors.base, fg = colors.highlight_med },
	HoverActiveSource = { bg = colors.overlay },
	HoverInactiveSource = { bg = colors.base },
	HoverSourceLine = { bg = colors.base },

	-- Links.
	HighlightUrl = { underline = true, fg = colors.love, sp = colors.love },

	-- Checkhealth
	healthsectionDelim = { fg = colors.gold, bg = 'none' },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end
