local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'williamboman/mason.nvim',

		opts = {
			ui = {
				border = vim.g.winborder,
				icons = require('icons').mason,
			},
		},
		on_setup = function()
			local bind = vim.keymap.set

			bind('n', '<leader>pm', '<cmd>Mason<cr>', { desc = 'Show mason' })
			bind('n', '<leader>pM', '<cmd>MasonUpdate<cr>', { desc = 'Update mason' })
		end,
	},
})
