vim.pack.add({
	{ 
		src = 'https://github.com/saghen/blink.cmp', 
		version = vim.version.range('1.*') 
	},
})

require('blink.cmp').setup({
	fuzzy = {
		implementation = 'prefer_rust',
	},
	keymap = {
		preset = 'super-tab',
		['<C-n>'] = { 'show', 'select_next' },
	},
	sources = {
		default = { 'lsp', 'path', 'snippets' },
	},
	cmdline = {
		enabled = true,
	},
	completion = {
		list = {
			selection = { auto_insert = true },
		},
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true,
			show_on_insert_on_trigger_character = true,
			show_on_accept_on_trigger_character = true,
		},
		menu = {
			auto_show = true,
			draw = {
				treesitter = { 'lsp' },
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind' },
					{ 'kind_icon' },
				},
			},
			border = 'rounded',
		},
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 500,
		},
	},
})
