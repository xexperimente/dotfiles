local add_on_event = require('pack').add_on_event

-- Improved quickfix UI.
add_on_event('UIEnter', {
	{
		src = 'stevearc/quicker.nvim',
		opts = {
			opts = {
				signcolumn = 'no',
			},
			borders = {
				vert = '|',
			},
			on_qf = function(bufnr)
				local winid = vim.fn.bufwinid(bufnr)
				vim.api.nvim_win_call(winid, function()
					-- vim.opt_local.listchars:append({ space = ' ' })
					vim.wo.statusline = ' %#FloatTitle#%q%#StatusLine#%* %= %l/%L'

					vim.cmd('redrawstatus')
				end)
			end,
		},
		on_setup = function()
			local toggle = require('quicker').toggle
			local bind = vim.keymap.set

			bind('n', '<leader>q', function() toggle({ focus = true }) end, { desc = 'Toggle quickfix' })
			bind('n', '<leader>l', function() toggle({ loclist = true, focus = true }) end, { desc = 'Toggle loclist' })
		end,
	},
})
