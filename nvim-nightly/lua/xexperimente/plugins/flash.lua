---@d iagnostic disable:undefined-field
vim.pack.add({ 'https://github.com/folke/flash.nvim' })

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

require('flash').setup(opts)

local bind = vim.keymap.set

bind({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, {})
bind({ 'o', 'x' }, 'S', function() require('flash').treesitter() end, {})
bind(
	{ 'n', 'x', 'o' },
	'<c-right>',
	function()
		require('flash').treesitter({
			actions = {
				['<c-right>'] = 'next',
				['<c-left>'] = 'prev',
			},
		})
	end,
	{ desc = 'Treesitter incremental selection' }
)
