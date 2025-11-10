vim.pack.add({ 'https://github.com/sontungexpt/witch-line' })

local function check_diff(value)
	if vim.b.minidiff_summary == nil or vim.b.minidiff_summary[value] == nil then return false end
	return true
end

require('witch-line').setup({
	components = {
		{
			[0] = 'mode',
			timing = true,
			style = function() return { fg = 'StatusLineActive' } end,
		},
		'|',
		{
			[0] = 'git.branch',
			style = function() return { fg = 'StatusLineActive' } end,
		},
		{
			id = 'tst.separator',
			events = 'User MiniDiffUpdated',
			padding = 0,
			style = { fg = 'StatusLine' },
			update = function()
				if vim.b.minidiff_summary == nil then return '' end

				local fields = { 'add', 'change', 'delete' }
				local count = 0
				for _, field in ipairs(fields) do
					count = count + vim.b.minidiff_summary[field]
				end
				return count > 0 and '|' or ''
			end,
		},
		{
			id = 'tst.diff.add',
			events = 'User MiniDiffUpdated',
			style = { fg = 'MiniDiffSignAdd' },
			update = function()
				if not check_diff('add') then return '' end
				return ' ' .. vim.b.minidiff_summary.add
			end,
		},
		{
			id = 'tst.diff.change',
			events = 'User MiniDiffUpdated',
			style = { fg = 'MiniDiffSignChange' },
			update = function()
				if not check_diff('change') then return '' end
				return ' ' .. vim.b.minidiff_summary.change
			end,
		},
		{
			id = 'tst.diff.delete',
			events = 'User MiniDiffUpdated',
			style = { fg = 'MiniDiffSignDelete' },
			update = function()
				if not check_diff('delete') then return '' end
				return ' ' .. vim.b.minidiff_summary.delete
			end,
		},
		'|',
		{
			id = 'filename',
			ref = {
				events = { 'file.name' },
			},
			style = { fg = 'StatusLineDim' },
			update = function() return '%t' end,
		},
		'%=',
		'diagnostic.info',
		'diagnostic.warn',
		'diagnostic.error',
		'lsp.clients',
		'|',
		{
			[0] = 'cursor.pos',
			style = function() return { fg = 'StatusLineDim' } end,
		},
		'|',
		{
			id = 'tst.progress',
			update = function(_, _) return '%p%%' end,
			events = 'CursorMoved',
			style = function() return { fg = 'StatusLineHighlight', bg = 'NONE' } end,
		},
	},
})
