local Plugin = { 'folke/flash.nvim' }

Plugin.event = 'VeryLazy'

Plugin.keys = {
	{ 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end },
	{ 'S', mode = { 'o', 'x' }, function() require('flash').treesitter() end },
}

Plugin.opts = {
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
		rainbow = { enabled = true },
		format = function(opts)
			return {
				{ ' ', opts.hl_group },
				{ opts.match.label, opts.hl_group },
				{ ' ', opts.hl_group },
			}
		end,
	},
}

return Plugin
