local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'sindrets/diffview.nvim',
		opts = {
			default_args = {
				DiffviewFileHistory = { '%' },
			},
		},
		on_setup = function()
			local bind = vim.keymap.set

			bind('n', '<leader>df', '<cmd>DiffviewFileHistory<cr>', { desc = 'Open file history' })
			bind('n', '<leader>dv', '<cmd>DiffviewOpen<cr>', { desc = 'Open diffview' })
			bind('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })
		end,
	},
})
