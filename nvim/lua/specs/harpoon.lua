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

	vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)

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
