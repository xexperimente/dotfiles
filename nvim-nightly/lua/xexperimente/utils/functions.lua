local M = {}

function M.show_messages()
	local messages = vim.api.nvim_exec2('messages', { output = true })

	Snacks.win({
		text = messages.output,
		width = 0.8,
		height = 0.6,
		border = 'single',
		wo = {
			spell = false,
			wrap = false,
			signcolumn = 'yes',
			statuscolumn = ' ',
			conceallevel = 3,
		},
		keys = {
			['<Esc>'] = 'close',
		},
	}):set_title('Messages', 'center')
end

function M.show_info()
	Snacks.win({
		file = vim.api.nvim_get_runtime_file('doc/news.txt', true)[1],
		width = 0.6,
		height = 0.6,
		border = 'single',
		wo = {
			spell = false,
			wrap = false,
			signcolumn = 'yes',
			statuscolumn = ' ',
			conceallevel = 3,
		},
		keys = {
			['<Esc>'] = 'close',
		},
	}):set_title('News', 'center')
end

function M.open_config()
	local config = vim.fn.stdpath('config')
	local path = ''
	if type(config) == 'table' then
		path = config[1] or ''
	else
		path = config
	end
	vim.api.nvim_set_current_dir(path)
	Snacks.picker.files()
end

function M.dashboard_file_format(item, ctx)
	local fname = vim.fn.fnamemodify(item.file, ':~')
	fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
	if #fname > ctx.width then
		local dir = vim.fn.fnamemodify(fname, ':h')
		local file = vim.fn.fnamemodify(fname, ':t')
		--- @diagnostic disable-next-line: unnecessary-if
		if dir and file then
			file = file:sub(math.floor(-(ctx.width - #dir - 2)))
			fname = dir .. '\\…' .. file
		end
	end
	local dir, file = fname:match('^(.*)\\(.+)$')
	return dir and { { dir .. '\\', hl = 'SnacksPickerDir' }, { file, hl = 'SnacksDashboardFile' } }
		or { { fname, hl = 'SnacksDashboardFile' } }
end

return M
