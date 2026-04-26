vim.schedule(function()
	vim.pack.add({
		'https://github.com/jakewvincent/mkdnflow.nvim',
		'https://github.com/MeanderingProgrammer/render-markdown.nvim',
	})

	require('mkdnflow').setup({})
	require('render-markdown').setup({
		file_types = { 'markdown', 'md' },
		render_modes = { 'n', 'c', 't' },
		anti_conceal = { enabled = false },
		html = { enabled = false },
		latex = { enabled = false },
		code = {
			sign = false,
			border = 'thin',
			width = 'block',
			inline_pad = 1,
			left_pad = 2,
			right_pad = 2,
			language_icon = false,
			language_name = false,
			language_left = '█',
			language_right = '█',
			language_border = '▄', -- ▃
		},
		heading = {
			sign = false,
			width = 'block',
			right_pad = 1,
			position = 'inline',
			icons = { ' 󰎤 ', ' 󰎧 ', ' 󰎪 ', ' 󰎭 ', ' 󰎱 ', ' 󰎳 ' },
			backgrounds = { 'FloatTitle' },
			foregrounds = { 'FloatTitle' },
		},
		link = { footnote = { enabled = true, icon = '' } },
		bullet = { left_pad = 1, icons = { '', '' } }, -- '', '', '', '' } },
		completions = { lsp = { enabled = true } },
	})
end)
