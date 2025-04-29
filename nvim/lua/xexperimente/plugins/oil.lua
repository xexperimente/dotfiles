local Plugin = { 'stevearc/oil.nvim' }

Plugin.opts = {
	win_options = {
		number = false,
		cursorline = true,
		cursorlineopt = 'screenline',
	},
	float = {
		max_width = 0.5,
		max_height = 0.8,
		border = 'single',
	},

	keymaps = {
		['q'] = { 'actions.close', mode = 'n' },
		['<BS>'] = { 'actions.parent', mode = 'n' },
		['<M-p>'] = { 'actions.preview', mode = 'n' },
		['<C-v>'] = { 'actions.select', opts = { vertical = true } },
		['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
	},
}

Plugin.keys = {
	{ '<leader>fe', '<cmd>Oil --float<cr>', desc = 'Oil file manager' },
}

return Plugin
