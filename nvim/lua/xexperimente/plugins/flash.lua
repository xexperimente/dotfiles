vim.schedule(function()
	vim.pack.add({ 'https://github.com/folke/flash.nvim' })

	local opts = {
		modes = {
			search = { enabled = true },
			treesitter = { label = { before = false, after = false } },
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
	local actions = { ['<M-i>'] = 'next', ['<M-o>'] = 'prev' }

	bind(modes, 's', function() flash.jump() end, { desc = 'Flash' })
	bind(modes, '<M-i>', function() flash.treesitter({ actions = actions }) end, { desc = 'Incremental selection' })
	bind('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
	bind({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
end)
