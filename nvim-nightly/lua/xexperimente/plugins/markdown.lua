vim.pack.add({ 'https://github.com/oxy2dev/markview.nvim' })

vim.defer_fn(function()
	require('markview').setup({
		-- preview = {
		-- 	icon_provider = 'mini', -- "mini" or "devicons"
		-- },
		markdown = {
			headings = {
				enable = true,

				heading_1 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰎤 ',
					sign = '',
					hl = 'MarkviewHeading1',
				},
				heading_2 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰎧 ',
					sign = '',
					hl = 'MarkviewHeading2',
				},
				heading_3 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰎪 ',
					sign = '',
					hl = 'MarkviewHeading3',
				},
				heading_4 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰎭 ',
					sign = '',
					hl = 'MarkviewHeading4',
				},
				heading_5 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰼓 ',
					sign = '',
					hl = 'MarkviewHeading5',
				},
				heading_6 = {
					style = 'label',
					padding_right = ' ',
					icon = ' 󰎳 ',
					sign = '',
					hl = 'MarkviewHeading6',
				},

				setext_1 = {
					style = 'decorated',

					sign = '󰌕 ',
					sign_hl = 'MarkviewHeading1Sign',
					icon = '  ',
					hl = 'MarkviewHeading1',
					border = '▂',
				},
				setext_2 = {
					style = 'decorated',

					sign = '󰌖 ',
					sign_hl = 'MarkviewHeading2Sign',
					icon = '  ',
					hl = 'MarkviewHeading2',
					border = '▁',
				},

				shift_width = 0,

				org_indent = false,
				org_indent_wrap = true,
				org_shift_char = ' ',
				org_shift_width = 1,
			},
		},
	})
end, 60)
-- vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
--
-- vim.defer_fn(function()
-- 	require('render-markdown').setup({
-- 		file_types = { 'markdown', 'md' },
-- 		render_modes = { 'n', 'no', 'c', 't', 'i', 'ic' },
-- 		-- anti_conceal = { enabled = false },
-- 		html = { enabled = false },
-- 		latex = { enabled = false },
-- 		code = {
-- 			sign = false,
-- 			border = 'thin',
-- 			position = 'right',
-- 			width = 'block',
-- 			above = '▁',
-- 			below = '▔',
-- 			language_icon = false,
-- 			-- language_name = false,
-- 			language_left = '█',
-- 			language_right = '█',
-- 			language_border = '▁',
-- 			left_margin = 0,
-- 			left_pad = 2,
-- 			right_pad = 2,
-- 			inline = true,
-- 			inline_pad = 1,
-- 		},
-- 		heading = {
-- 			sign = false,
-- 			width = 'block',
-- 			left_pad = 0,
-- 			right_pad = 2,
-- 			position = 'overlay',
-- 			icons = { ' 󰎤 ', ' 󰎧 ', ' 󰎪 ', ' 󰎭 ', ' 󰎱 ', ' 󰎳 ' },
-- 		},
-- 		link = {
-- 			enabled = true,
-- 			footnote = {
-- 				enabled = true,
-- 				icon = '',
-- 			},
-- 		},
--
-- 		bullet = {
-- 			right_pad = 0,
-- 			left_pad = 1,
-- 			icons = { '', '', '', '' },
-- 		},
-- 		completions = { lsp = { enabled = true } },
-- 	})
-- end, 80)
