vim.pack.add({ 'https://github.com/sontungexpt/witch-line' }, { load = function() end })

function check_diff(value)
	if vim.b.minidiff_summary == nil or vim.b.minidiff_summary[value] == nil then return 0 end
	return vim.b.minidiff_summary[value]
end

vim.api.nvim_create_autocmd('User', {
	once = true,
	group = vim.api.nvim_create_augroup('StatuslineLazyLoad', {}),
	pattern = 'PackLazy',
	callback = function()
		vim.cmd('packadd witch-line')
		require('witch-line').setup({
			statusline = {
				cache = {
					notification = false,
					func_strip = true,
				},
				global = {
					{
						[0] = 'mode',
						timing = true,
						style = function() return { fg = 'StatusLineActive' } end,
					},
					{
						[0] = 'git.branch',
						left = '|',
						style = function() return { fg = 'StatusLineActive' } end,
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
						style = function() return { fg = 'StatusLineDim' } end,
						update = function() return '%t' end,
					},
					{
						[0] = 'file.modifier',
						padding = 0,
						style = function() return { fg = 'StatusLineDim' } end,
					},
					'%=',
					'diagnostic.info',
					'diagnostic.warn',
					'diagnostic.error',
					'lsp.clients',
					{
						[0] = 'search.count',
						timing = 200,
						style = function() return { link = 'IncSearch' } end,
						left = '|',
					},
					{
						[0] = 'cursor.pos',
						left = '|',
						style = function() return { fg = 'StatusLineDim' } end,
					},
					{
						id = 'tst.progress',
						update = function(_, _) return '%p%%' end,
						events = 'CursorMoved',
						left = '|',
						style = function() return { fg = 'StatusLineHighlight', bg = 'NONE' } end,
					},
				},
				-- @type fun(winid): CombinedComponent[]|nil
				win = nil,
			},
			disabled = {
				filetypes = { 'snacks_dashboard' },
				-- buftypes = { 'nofile' },
			},
		})
	end,
})
