local Plugin = { 'VonHeikemen/searchbox.nvim' }

Plugin.lazy = true
Plugin.dependencies = { 'MunifTanjim/nui.nvim' }

Plugin.cmd = {
	'SearchBoxIncSearch',
	'SearchBoxMatchAll',
	'SearchBoxReplace',
}

Plugin.keys = {
	{ '<leader>s', ':SearchBoxMatchAll<cr>', mode = 'n', noremap = true, desc = 'SearchBox' },
	{ '<leader>r', ':SearchBoxReplace<cr>', mode = 'n', noremap = true, desc = 'SearchBox(Replace)' },
	{ '<leader>s', ':SearchBoxMatchAll visual_mode=true<cr>', mode = 'v', noremap = true, desc = 'SearchBox' },
	{ '<leader>r', ':SearchBoxReplace visual_mode=true<cr>', mode = 'v', noremap = true, desc = 'SearchBox(Replace)' },
}

Plugin.opts = {
	defaults = {
		show_matches = true,
	},
	popup = {
		position = {
			row = '50%',
			col = '50%',
		},
		size = 50,
		border = {
			style = 'single',
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
	hooks = {
		after_mount = function(input)
			local opts = { buffer = input.bufnr, noremap = false }

			vim.keymap.set('i', '<F3>', '<Plug>(searchbox-next-match)', opts)
			vim.keymap.set('i', '<S-F3>', '<Plug>(searchbox-prev-match)', opts)
		end,
	},
}

return Plugin
