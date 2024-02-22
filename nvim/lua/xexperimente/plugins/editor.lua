return {

	-- Colored brace pairs
	{
		'hiphish/rainbow-delimiters.nvim',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			local rainbow_delimiters = require('rainbow-delimiters')

			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = rainbow_delimiters.strategy['global'],
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
				},
			}
		end,
	},

	-- Escape insert mode with jk
	{
		'max397574/better-escape.nvim',
		event = 'InsertEnter',
		opts = {},
	},

	-- LSP lenses - show definitions and references of symbol
	{
		'vidocqh/lsp-lens.nvim',
		event = { 'BufRead', 'BufNewFile' },
		cmd = { 'LspLensOn', 'LspLensOff', 'LspLensToggle' },
		opts = {
			include_declaration = true,
			sections = {
				definition = false,
			},
		},
	},

	-- Multicursor
	{
		'mg979/vim-visual-multi',
		branch = 'master',
		lazy = false,
		init = function()
			vim.g.VM_maps = {
				['Find Under'] = '<C-d>',
				['Find Subword Under'] = '<C-d>',
				['Select Cursor Down'] = '<M-C-Down>',
				['Select Cursor Up'] = '<M-C-Up>',
			}
		end,
	},
}
