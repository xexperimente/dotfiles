vim.pack.add({ 'https://github.com/sontungexpt/witch-line' })

function check_diff(value)
	if vim.b.minidiff_summary == nil or vim.b.minidiff_summary[value] == nil then return 0 end
	return vim.b.minidiff_summary[value]
end

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
				id = 'tst.diff.add',
				events = { 'User MiniDiffUpdated', 'BufEnter' },
				style = { fg = 'MiniDiffSignAdd' },
				left = '|',
				update = function() return check_diff('add') > 0 and ' ' .. vim.b.minidiff_summary.add or '' end,
			},
			{
				id = 'tst.diff.change',
				events = { 'User MiniDiffUpdated', 'BufEnter' },
				style = { fg = 'MiniDiffSignChange' },
				update = function(self)
					self.left = check_diff('add') == 0 and '|' or ''
					return check_diff('change') > 0 and ' ' .. vim.b.minidiff_summary.change or ''
				end,
			},
			{
				id = 'tst.diff.delete',
				events = { 'User MiniDiffUpdated', 'BufEnter' },
				style = { fg = 'MiniDiffSignDelete' },
				update = function(self)
					self.left = check_diff('change') == 0 and '|' or ''
					return check_diff('delete') > 0 and ' ' .. vim.b.minidiff_summary.delete or ''
				end,
			},
			{
				[0] = 'file.name',
				left = '|',
				style = { fg = 'StatusLineDim' },
				update = function() return '%t' end,
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
