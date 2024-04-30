local Plugin = { 'VonHeikemen/searchbox.nvim' }

Plugin.lazy = true

Plugin.dependencies = {
	'MunifTanjim/nui.nvim',
}

Plugin.cmd = { 'SearchBoxIncSearch', 'SearchBoxMatchAll', 'SearchBoxSimple', 'SearchBoxReplace' }

Plugin.keys = {
	{
		'<leader>S',
		':SearchBoxIncSearch<CR>',
		{ noremap = true, desc = 'SearchBox' },
	},
}

Plugin.opts = {
	popup = {
		position = {
			row = '50%',
			col = '50%',
		},
		border = {
			style = 'solid',
			text = {
				top = { { 'Search', 'TelescopeResultsTitle' } },
				top_align = 'center',
			},
			padding = { 1, 1 },
		},
		win_options = {
			winhighlight = 'Normal:NormalFloat,FloatBorder:NormalFloat',
		},
	},
}

return Plugin
