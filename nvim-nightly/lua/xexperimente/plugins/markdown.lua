vim.pack.add(
	{
		'https://github.com/MeanderingProgrammer/render-markdown.nvim',
	}
	-- , { load = false }
)

vim.defer_fn(function()
	require('render-markdown').setup({
		file_types = { 'markdown', 'md' },
		render_modes = { 'n', 'no', 'c', 't', 'i', 'ic' },
		html = { enabled = false },
		latex = { enabled = false },
		code = {
			sign = false,
			border = 'thick',
			-- position = 'right',
			width = 'block',
			above = '▁',
			below = '▔',
			language_icon = false,
			language_name = false,
			language_left = '█',
			language_right = '█',
			language_border = '▁',
			left_pad = 2,
			right_pad = 2,
			inline = true,
			inline_pad = 1,
		},
		heading = {
			sign = false,
			width = 'block',
			left_pad = 1,
			right_pad = 0,
			position = 'right',
			icons = { '', '', '', '', '', '' },
		},
		link = {
			enabled = true,
			footnote = {
				enabled = true,
				icon = '',
			},
		},
		completions = { lsp = { enabled = true } },
	})
end, 80)
