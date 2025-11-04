vim.pack.add({
	'https://github.com/VonHeikemen/searchbox.nvim',
})

local opts = {
	defaults = {
		show_matches = true,
	},
	popup = {
		position = {
			row = '50%',
			col = '50%',
		},
		size = 50,
		border = {
			style = 'single',
			text = {
				top = { { ' Search ', 'FloatTitle' } },
				top_align = 'center',
			},
			padding = { 0, 1 },
		},
		win_options = {
			winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
		},
	},
}

require('searchbox').setup(opts)

local bind = vim.keymap.set

-- bind('n', '<leader>s', '<cmd>SearchBoxMatchAll<cr>', { noremap = true, desc = 'Searchbox' })
bind('n', '<leader>r', '<cmd>SearchBoxReplace<cr>', { noremap = true, desc = 'Searchbox(Replace)' })
-- bind('v', '<leader>s', '<cmd>SearchBoxMatchAll visual_mode=true<cr>', { noremap = true, desc = 'Searchbox' })
bind('v', '<leader>r', '<cmd>SearchBoxReplace visual_mode=true<cr>', { noremap = true, desc = 'Searchbox(Replace)' })
