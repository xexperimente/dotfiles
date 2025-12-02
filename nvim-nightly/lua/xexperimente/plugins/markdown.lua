vim.pack.add({
	'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}, { load = false })

require('render-markdown').setup({
	file_types = { 'markdown', 'md' },
	render_modes = { 'n', 'no', 'c', 't', 'i', 'ic' },
	html = { enabled = false },
	latex = { enabled = false },
	code = {
		sign = false,
		border = 'thin',
		-- position = 'right',
		width = 'block',
		above = '▁',
		below = '▔',
		language_left = '█',
		language_right = '█',
		language_border = '▁',
		left_pad = 1,
		right_pad = 1,
		inline = true,
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
