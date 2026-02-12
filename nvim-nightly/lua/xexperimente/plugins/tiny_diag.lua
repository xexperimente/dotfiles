vim.pack.add({ 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' })

vim.defer_fn(function()
	require('tiny-inline-diagnostic').setup({
		preset = 'powerline',
		options = {
			show_source = true,
			show_all_diags_on_cursorline = true,
			multilines = {
				enabled = true,
				always_show = false, -- show only current line diagnostics
			},
		},
		hi = {
			background = 'Normal',
		},
	})
end, 80)
