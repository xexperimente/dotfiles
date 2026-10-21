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
			local quick = require('quicker')
			local bind = vim.keymap.set

			bind('n', '<leader>xq', function() quick.toggle() end, { desc = 'Toggle quickfix' })
			bind('n', '<leader>xl', function() quick.toggle({ loclist = true }) end, { desc = 'Toggle loclist list' })
			bind('n', '>', function() quick.expand({ add_to_existing = true }) end, { desc = 'Expand context' })
			bind('n', '<', function() quick.collapse() end, { desc = 'Collapse context' })
		end,
	},
})
