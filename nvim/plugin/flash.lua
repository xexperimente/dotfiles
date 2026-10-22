local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'folke/flash.nvim',
		opts = {
			modes = {
				search = { enabled = false },
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
			prompt = {
				prefix = { { ' ', 'FlashPromptIcon' } },
				win_config = {
					border = 'single',
					width = 60,
					height = 1,
					row = -15,
					col = math.floor(vim.o.columns / 2) - 30,
					title = ' Flash ',
					title_pos = 'center',
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
		},
		on_setup = function()
			local bind = vim.keymap.set
			local exp = vim.fn.expand
			local flash = require('flash')

			local modes = { 'n', 'x', 'o' }
			local actions = { ['<M-i>'] = 'next', ['<M-o>'] = 'prev' }

			local function search_visual_selection_text()
				local selection = vim.fn.getreg('"')
				vim.cmd('normal! "ay')
				flash.jump({ pattern = vim.fn.getreg('a') })
				vim.fn.setreg('"', selection)
			end

			bind(modes, 's', flash.jump, { desc = 'Flash' })
			bind('n', '<c-f>', flash.jump, { desc = 'Flash' })
			bind('n', '<c-s-f>', function() flash.jump({ pattern = exp('<cword>') }) end, { desc = 'Flash search(cword)' })
			bind('v', '<c-f>', search_visual_selection_text, { desc = 'Flash search(selection)' })

			bind(modes, 's', flash.jump, { desc = 'Flash' })
			bind('c', '<c-s>', flash.toggle, { desc = 'Toggle Flash when searching' })

			bind({ 'o', 'x' }, 'R', flash.treesitter_search, { desc = 'Treesitter Search' })
			bind(modes, '<M-i>', function() flash.treesitter({ actions = actions }) end, { desc = 'Incremental selection' })
		end,
	},
})
