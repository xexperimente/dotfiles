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

	local conf = require('telescope.config').values

	local function toggle_telescope(harpoon_files)
		local finder = function()
			local paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(paths, item.value)
			end

			return require('telescope.finders').new_table({
				results = paths,
			})
		end

		require('telescope.pickers')
			.new({}, {
				prompt_title = 'Harpoon',
				theme = 'dropdown',
				layout_config = {
					height = 0.4,
					width = 0.5,
					prompt_position = 'bottom',
					preview_cutoff = 120,
				},
				finder = finder(),
				previewer = false, --conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(prompt_bufnr, map)
					map('i', '<C-d>', function()
						local state = require('telescope.actions.state')
						local selected_entry = state.get_selected_entry()
						local current_picker = state.get_current_picker(prompt_bufnr)

						table.remove(harpoon_files.items, selected_entry.index)
						current_picker:refresh(finder())
					end)
					return true
				end,
			})
			:find()
	end

	vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
	vim.keymap.set('n', '<leader>h', function() toggle_telescope(harpoon:list()) end)

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
