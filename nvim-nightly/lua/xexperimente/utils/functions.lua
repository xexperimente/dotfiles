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

-- Delete buffer and if no other buffer exists show dashboard
function M.bufdelete_or_dashboard()
	Snacks.bufdelete(0)

	local buffers = vim.tbl_filter(
		function(buf)
			return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ''
		end,
		vim.api.nvim_list_bufs()
	)

	if #buffers == 0 then
		-- close extra splits and open dashboard
		vim.cmd('only')
		require('snacks').dashboard.open()

		-- Find and delete NoName buffers after mini.starter is open
		vim.defer_fn(function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local name = vim.api.nvim_buf_get_name(buf)
				if name == '' and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
					vim.api.nvim_buf_delete(buf, { force = false })
				end
			end
		end, 300)
	end
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

function M.show_plugins()
	local items = {}

	for idx, plugin in ipairs(vim.pack.get()) do
		local item = {
			idx = idx,
			name = plugin.spec.name,
			active = plugin.active,
			icon = plugin.active and '' or '',
			text = ' ' .. plugin.spec.name,
			rev = (plugin.rev == nil) and '' or plugin.rev,
			action = function() dd(plugin) end,
		}
		table.insert(items, item)
	end

	Snacks.picker({
		title = 'Plugins',
		layout = {
			preset = 'select',
			preview = false,
			width = 0.5,
		},
		items = items,
		format = function(item, _)
			local a = Snacks.picker.util.align
			local ret = {} -- -@type snacks.picker.Highlight[]

			ret[#ret + 1] = { item.icon, item.active and 'SnacksPickerIdx' or 'Comment' }
			ret[#ret + 1] = { a(item.text, 40), item.text_hl }
			ret[#ret + 1] = { ' ' }

			ret[#ret + 1] = { a(item.rev, 8, { align = 'right' }), item.text_hl }

			return ret
		end,
		confirm = function(picker, item)
			return picker:norm(function()
				picker:close()
				item.action()
			end)
		end,
	})
end

return M
