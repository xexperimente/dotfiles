vim.pack.add({ 'https://github.com/sontungexpt/witch-line' })

local opts = {
	auto_theme = false,
	cache = {
		enabled = false,
		notification = false,
		func_strip = false,
	},
	statusline = {
		global = {
			{
				[0] = 'mode',
				timing = true,
				static = {
					mode_colors = {
						[1] = { fg = 'StatusLineActive' }, -- NORMAL
						[2] = { fg = 'StatusLineActive' }, -- NTERMINAL
						[3] = { fg = 'StatusLineActive' }, -- VISUAL
						[4] = { fg = 'StatusLineActive' }, -- INSERT
						[5] = { fg = 'StatusLineActive' }, -- TERMINAL
						[6] = { fg = 'StatusLineActive' }, -- REPLACE
						[7] = { fg = 'StatusLineActive' }, -- SELECT
						[8] = { fg = 'StatusLineActive' }, -- COMMAND
						[9] = { fg = 'StatusLineActive' }, -- CONFIRM
					},
				},
			},
			{
				[0] = 'git.branch',
				left = '|',
				style = { fg = 'StatusLineActive' },
			},
			{
				[0] = 'git.diff.added',
				static = { icon = '' },
				left = '|',
				style = { fg = 'MiniDiffSignAdd' },
			},
			{
				[0] = 'git.diff.modified',
				static = { icon = '' },
				style = { fg = 'MiniDiffSignChange' },
			},
			{
				[0] = 'git.diff.removed',
				static = { icon = '' },
				style = { fg = 'MiniDiffSignDelete' },
			},
			{
				[0] = 'file.name',
				left = '|',
				style = { fg = 'StatusLineDim' },
				-- update = function() return '%t' end,
			},
			{
				[0] = 'file.modifier',
				padding = 0,
				style = { fg = 'StatusLineDim' },
			},
			'%=',
			'diagnostic.info',
			'diagnostic.warn',
			'diagnostic.error',
			'lsp.clients',
			{
				[0] = 'search.count',
				timing = 200,
				style = { link = 'IncSearch' },
				left = '|',
			},
			{
				[0] = 'encoding',
				left = '|',
			},
			{
				[0] = 'cursor.pos',
				left = '|',
				style = { fg = 'StatusLineDim' },
			},
			{
				id = 'tst.progress',
				update = function(_, _) return '%p%%' end,
				events = 'CursorMoved',
				left = '|',
				style = { fg = 'StatusLineHighlight', bg = 'NONE' },
			},
		},
		win = nil,
	},
	disabled = {
		filetypes = { 'snacks_dashboard' },
		-- buftypes = { 'nofile' },
	},
}

require('witch-line').setup(opts)
