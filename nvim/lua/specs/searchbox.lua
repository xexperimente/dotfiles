local Plugin = { 'VonHeikemen/searchbox.nvim' }

Plugin.lazy = true
Plugin.dependencies = { 'MunifTanjim/nui.nvim' }

Plugin.cmd = {
	'SearchBoxIncSearch',
	'SearchBoxMatchAll',
	'SearchBoxReplace',
}

Plugin.keys = {
	{ '<leader>S', ':SearchBoxIncSearch title=Search(IncSearch)<CR>', noremap = true, desc = 'SearchBox(IncSearch)' },
	{ '<leader>s', ':SearchBoxMatchAll<CR>', noremap = true, desc = 'SearchBox' },
	{ '<leader>r', ':SearchBoxReplace<CR>', noremap = true, desc = 'SearchBox(Replace)' },
}

Plugin.opts = {
	popup = {
		position = {
			row = '50%',
			col = '50%',
		},
		border = {
			style = require('user.env').border,
			text = {
				top = { { ' Search ', 'MiniPickBorderText' } },
				top_align = 'center',
			},
			padding = { 0, 1 },
		},
		win_options = {
			winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
		},
	},
}

return Plugin
