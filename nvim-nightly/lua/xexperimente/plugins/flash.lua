vim.pack.add({ 'https://github.com/folke/flash.nvim' })

vim.defer_fn(function()
	local opts = {
		modes = {
			search = { enabled = true },
		},
		search = {
			exclude = {
				'notify',
				'cmp_menu',
				'noice',
				'flash_prompt',
				'blink-cmp-menu',
				function(win)
					-- exclude non-focusable windows
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
		},
		label = {
			rainbow = { enabled = false },
			style = 'eol',
			format = function(args)
				return {
					{ ' ', args.hl_group },
					{ args.match.label, args.hl_group },
					{ ' ', args.hl_group },
				}
			end,
		},
	}

	local bind = vim.keymap.set
	local flash = require('flash')

	flash.setup(opts)

	local modes = { 'n', 'x', 'o' }
	local actions = { ['<c-right>'] = 'next', ['<c-left>'] = 'prev' }

	bind(modes, 's', function() flash.jump() end, { desc = 'Flash' })
	bind(modes, 'S', function() flash.treesitter() end, { desc = 'Flash treesitter' })
	bind(modes, '<c-right>', function() flash.treesitter({ actions = actions }) end, { desc = 'Incremental selection' })
	bind('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
end, 80)
