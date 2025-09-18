vim.pack.add({
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('1.*'),
	},
})

require('blink.cmp').setup({
	fuzzy = {
		implementation = 'prefer_rust',
	},
	keymap = {
		preset = 'super-tab',
		['<C-n>'] = { 'show', 'select_next' },
		['<CR>'] = { 'accept', 'fallback' },
	},
	sources = {
		default = { 'lsp', 'path', 'snippets' },
		min_keyword_length = 2,
	},
	cmdline = {
		enabled = true,
		keymap = {
			['<Tab>'] = { 'show_and_insert_or_accept_single', 'accept' },
			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },
		},
	},
	completion = {
		list = {
			selection = {
				auto_insert = false,
				preselect = true,
			},
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
					{ 'kind_icon' },
					{ 'label', 'label_description', gap = 1 },
					{ 'kind' },
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
