local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = vim.version.range('*') } end

vim.pack.add({
	gh('folke/noice.nvim'),
	gh('MunifTanjim/nui.nvim'),
})

require('noice').setup({
	presets = {
		bottom_search = false,
		lsp_doc_border = true,
	},
	lsp = {
		progress = { enabled = false },
		override = {
			['vim.lsp.util.convert_input_to_markdown_lines'] = true,
			['vim.lsp.util.stylize_markdown'] = true,
		},
	},
	views = {
		cmdline_popup = {
			position = {
				row = '70%',
				col = '50%',
			},
			border = { style = 'single' },
		},
		hover = {
			size = { max_height = 10 },
			border = { style = 'single' },
		},
	},
	messages = { view_search = false },
	cmdline = {
		format = {
			cmdline = { icon = '󰘧' },
			lua = { icon = 'lua' },
		},
	},
	popupmenu = { enabled = false },
	notify = { enabled = false },
})
