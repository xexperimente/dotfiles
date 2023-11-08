local Plugin = { 'folke/flash.nvim' }

Plugin.event = 'VeryLazy'

Plugin.config = true

Plugin.keys = {
	{ 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end },
	{ 'S', mode = { 'o', 'x' }, function() require('flash').treesitter() end },
}

Plugin.opts = {
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
