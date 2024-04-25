local Plugin = { 'theprimeagen/harpoon' }

Plugin.lazy = true

Plugin.branch = 'harpoon2'

Plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
}

function Plugin.config()
	local harpoon = require('harpoon')

	harpoon.setup()

	require('telescope').load_extension('harpoon')
	--
	-- local conf = require('telescope.config').values
	--
	-- local function toggle_telescope(harpoon_files)
	-- 	-- local finder = function()
	-- 	-- 	local paths = {}
	-- 	-- 	for index, item in ipairs(harpoon_files.items) do
	-- 	-- 		table.insert(paths, item.value)
	-- 	-- 	end
	-- 	--
	-- 	-- 	return require('telescope.finders').new_table({
	-- 	-- 		results = paths,
	-- 	-- 	})
	-- 	-- end
	--
	-- 	local finders = require('telescope.finders')
	-- 	local entry_display = require('telescope.pickers.entry_display')
	--
	-- 	local function filter_empty_string(list)
	-- 		local next = {}
	-- 		for idx = 1, #list do
	-- 			if list[idx].value ~= '' then
	-- 				local item = list[idx]
	-- 				table.insert(next, {
	-- 					index = idx,
	-- 					value = item.value,
	-- 					context = {
	-- 						row = item.context.row,
	-- 						col = item.context.col,
	-- 					},
	-- 				})
	-- 			end
	-- 		end
	--
	-- 		return next
	-- 	end
	--
	-- 	local generate_new_finder = function()
	-- 		local results = filter_empty_string(harpoon:list().items)
	-- 		local results_idx_str_len = string.len(tostring(#results))
	-- 		return finders.new_table({
	-- 			results = results,
	-- 			entry_maker = function(entry)
	-- 				local entry_idx_str = tostring(entry.index)
	-- 				local entry_idx_str_len = string.len(entry_idx_str)
	-- 				local entry_idx_lpad = string.rep(' ', results_idx_str_len - entry_idx_str_len)
	-- 				local line = entry.value .. ':' .. entry.context.row .. ':' .. entry.context.col
	-- 				local displayer = entry_display.create({
	-- 					separator = ' - ',
	-- 					items = {
	-- 						{ width = results_idx_str_len },
	-- 						{ width = 50 },
	-- 						{ remaining = true },
	-- 					},
	-- 				})
	-- 				local make_display = function()
	-- 					return displayer({
	-- 						entry_idx_lpad .. entry_idx_str,
	-- 						line,
	-- 					})
	-- 				end
	-- 				return {
	-- 					value = entry,
	-- 					ordinal = line,
	-- 					display = make_display,
	-- 					lnum = entry.row,
	-- 					col = entry.col,
	-- 					filename = entry.value,
	-- 				}
	-- 			end,
	-- 		})
	-- 	end
	--
	-- 	require('telescope.pickers')
	-- 		.new({}, {
	-- 			prompt_title = false,
	-- 			results_title = 'Harpoon',
	-- 			theme = 'dropdown',
	-- 			layout_config = {
	-- 				height = 0.4,
	-- 				width = 0.5,
	-- 				prompt_position = 'bottom',
	-- 				preview_cutoff = 120,
	-- 			},
	-- 			borderchars = {
	-- 				prompt = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
	-- 				results = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
	-- 				preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
	-- 			},
	-- 			finder = generate_new_finder(),
	-- 			previewer = false, --conf.file_previewer({}),
	-- 			sorter = conf.generic_sorter({}),
	-- 			attach_mappings = function(prompt_bufnr, map)
	-- 				map('i', '<C-d>', function()
	-- 					local state = require('telescope.actions.state')
	-- 					local selected_entry = state.get_selected_entry()
	-- 					local current_picker = state.get_current_picker(prompt_bufnr)
	--
	-- 					table.remove(harpoon_files.items, selected_entry.index)
	-- 					current_picker:refresh(generate_new_finder(), { reset_prompt = true })
	-- 				end)
	-- 				return true
	-- 			end,
	-- 		})
	-- 		:find()
	-- end

	vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
	-- vim.keymap.set('n', '<leader>h', function() toggle_telescope(harpoon:list()) end)

	vim.keymap.set(
		'n',
		'<leader>h',
		'<cmd>Telescope harpoon marks layout_strategy=vertical previewer=false<cr>'
	)
	vim.keymap.set('n', '<M-F1>', function() harpoon:list():select(1) end)
	vim.keymap.set('n', '<M-F2>', function() harpoon:list():select(2) end)
	vim.keymap.set('n', '<M-F3>', function() harpoon:list():select(3) end)
	vim.keymap.set('n', '<M-F4>', function() harpoon:list():select(4) end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set('n', '[h', function() harpoon:list():prev() end)
	vim.keymap.set('n', ']h', function() harpoon:list():next() end)
end

Plugin.keys = {
	'<M-F1>',
	'<M-F2>',
	'<M-F3>',
	'<M-F4>',
	'<leader>h',
	'<leader>a',
	'<[h>',
	'<]h>',
}

return Plugin
