---@diagnostic disable: need-check-nil
local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'mcauley-penney/visual-whitespace.nvim',
		opts = {
			enabled = true,
			match_types = {
				space = true,
				tab = true,
				nbsp = true,
				lead = false,
				trail = false,
			},
			list_chars = {
				space = vim.opt.listchars:get().space or '·',
				tab = vim.opt.listchars:get().tab or '→ ',
				nbsp = vim.opt.listchars:get().nbsp or '⎵',
			},
			fileformat_chars = {
				unix = '',
				mac = '←',
				dos = '',
			},
		},
		on_setup = function()
			local bind = vim.keymap.set

			bind({ 'n', 'v' }, '<leader>us', require('visual-whitespace').toggle, { desc = 'Toggle visual whitespace' })
			bind('n', '<leader>uS', function()
				vim.notify(string.format('%s whitespace...', vim.o.list and 'Disabling' or 'Enabling'))
				vim.o.list = not vim.o.list
			end, { desc = 'Toggle whitespace' })
		end,
	},
})
