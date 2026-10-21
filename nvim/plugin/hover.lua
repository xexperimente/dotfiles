local add_on_event = require('pack').add_on_event

add_on_event('BufEnter', {
	{
		src = 'lewis6991/hover.nvim',
		on_setup = function()
			require('hover').config({
				providers = {
					'hover.providers.diagnostic',
					'hover.providers.lsp',
					'hover.providers.dap',
					'hover.providers.dictionary',
				},
			})
			local bind = vim.keymap.set
			local hover = require('hover')

			bind('n', 'K', function() hover.open() end, { desc = 'hover.nvim' })
			bind('n', 'gK', function() hover.enter() end, { desc = 'hover.nvim (enter)' })
			bind('n', '<C-PageUp>', function() hover.switch('previous') end, { desc = 'hover.nvim (previous source)' })
			bind('n', '<C-PageDown>', function() hover.switch('next') end, { desc = 'hover.nvim (next source)' })
		end,
	},
})
