local Plugin = { 'theprimeagen/harpoon' }

Plugin.lazy = true

Plugin.branch = 'harpoon2'

Plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
}

function Plugin.config()
	local bind = vim.keymap.set
	local harpoon = require('harpoon')

	harpoon.setup()

	require('telescope').load_extension('harpoon')

	bind('n', '<leader>a', function() harpoon:list():add() end)

	bind(
		'n',
		'<leader>h',
		'<cmd>Telescope harpoon marks layout_strategy=vertical previewer=false<cr>'
	)
	bind('n', '<M-F1>', function() harpoon:list():select(1) end)
	bind('n', '<M-F2>', function() harpoon:list():select(2) end)
	bind('n', '<M-F3>', function() harpoon:list():select(3) end)
	bind('n', '<M-F4>', function() harpoon:list():select(4) end)

	-- Toggle previous & next buffers stored within Harpoon list
	bind('n', '[h', function() harpoon:list():prev() end)
	bind('n', ']h', function() harpoon:list():next() end)
end

Plugin.keys = {
	{ '<M-F1>', desc = 'Go to harpoon mark 1' },
	{ '<M-F2>', desc = 'Go to harpoon mark 2' },
	{ '<M-F3>', desc = 'Go to harpoon mark 3' },
	{ '<M-F4>', desc = 'Go to harpoon mark 4' },
	{ '<leader>h', desc = 'Show harpoon list' },
	{ '<leader>a', desc = 'Add harpoon mark' },
	{ '<[h>', desc = 'Prev harpoon mark' },
	{ '<]h>', desc = 'Next harpoon mark' },
}

return Plugin
