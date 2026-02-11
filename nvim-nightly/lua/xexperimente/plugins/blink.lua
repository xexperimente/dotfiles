vim.pack.add({
	{ src = 'https://github.com/saghen/blink.cmp', version = 'v1.8.0' },
})

local opts = {
	fuzzy = {
		implementation = 'prefer_rust',
		prebuilt_binaries = { force_version = 'v1.8.0' },
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
			['<Tab>'] = { 'show', 'accept' },
			-- ['<CR>'] = { 'select_accept_and_enter', 'fallback' },
			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },
			['<Esc>'] = { 'hide', 'fallback' },
		},
		completion = {
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ 'label', 'label_description', gap = 1 },
					},
				},
			},
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
}

vim.defer_fn(function() require('blink.cmp').setup(opts) end, 100)
