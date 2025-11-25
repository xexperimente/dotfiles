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

function M.show_plugins()
	local items = {}

	items[#items + 1] = {
		name = 'Update',
		active = false,
		icon = '󰚰',
		text = 'Update all plugins',
		rev = '',
		action = function() vim.pack.update() end,
	}

	items[#items + 1] = {
		name = 'Update',
		active = false,
		icon = '󰚰',
		text = 'Update all plugins( force )',
		rev = '',
		action = function() vim.pack.update({}, { force = true }) end,
	}
	for _, plugin in ipairs(vim.pack.get()) do
		local item = {
			name = plugin.spec.name,
			active = plugin.active,
			icon = plugin.active and '' or '',
			text = plugin.spec.name,
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
			width = 0.4,
		},
		win = {
			input = { keys = { ['d'] = 'pack_delete' } },
			list = { keys = { ['d'] = 'pack_delete' } },
		},
		-- focus = 'list',
		actions = {
			pack_delete = function(_picker, item, _action)
				if item.name == 'Update' then return end
				vim.notify('vim.pack.del: ' .. item.name)
				vim.pack.del({ item.name })
			end,
		},
		items = items,
		format = function(item, _picker)
			local a = Snacks.picker.util.align
			local ret = {} -- -@type snacks.picker.Highlight[]

			ret[#ret + 1] = { a(item.icon, 2), 'Comment' }
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
