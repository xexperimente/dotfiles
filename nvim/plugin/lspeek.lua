local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'r4ppz/lspeek.nvim',
		opts = {
			window = {
				width = 70,
				height = 15,
				border = 'single',
			},
			stack_limit = 7,
			select_first = false,
			keymaps = {
				close = 'q',
				split = 's',
				vsplit = 'v',
				enter = '<CR>',
			},
		},
		on_setup = function()
			local bind = vim.keymap.set
			local ps = require('lspeek')

			bind('n', '<a-f12>', ps.peek_definition, { desc = 'Peek definition' })
			bind('n', '<c-f12>', ps.peek_type_definition, { desc = 'Peek type definition' })
		end,
	},
})
