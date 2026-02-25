vim.pack.add({
	'https://github.com/jakewvincent/mkdnflow.nvim',
	'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

vim.defer_fn(function()
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
			position = 'right',
			width = 'block',
			above = '▄', --'▁',
			below = '▀', --'🮂', -- '▔',
			language_icon = false,
			-- language_name = false,
			language_info = true,
			language_left = '█',
			language_right = '█',
			language_border = '▄', --'▃', -- ▁
			left_margin = 0,
			left_pad = 2,
			right_pad = 2,
			inline = true,
			inline_pad = 1,
			highlight_language = 'RenderMarkdownCodeLanguage',
		},
		heading = {
			sign = false,
			width = 'block',
			left_pad = 0,
			right_pad = 1,
			position = 'inline',
			icons = { ' 󰎤 ', ' 󰎧 ', ' 󰎪 ', ' 󰎭 ', ' 󰎱 ', ' 󰎳 ' },
		},
		link = {
			enabled = true,
			footnote = {
				enabled = true,
				icon = '',
			},
		},
		bullet = {
			right_pad = 0,
			left_pad = 1,
			icons = { '', '', '', '' },
		},
		completions = { lsp = { enabled = true } },
	})
end, 80)
