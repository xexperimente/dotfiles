vim.schedule(function()
	vim.pack.add({
		{ src = 'https://github.com/saghen/blink.cmp', version = 'v1.9.1' },
	})

	local opts = {
		fuzzy = {
			implementation = 'prefer_rust',
			prebuilt_binaries = { force_version = 'v1.9.1' },
		},
		keymap = {
			preset = 'super-tab',
			['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },
		},
		sources = { default = { 'lsp', 'path', 'snippets' }, min_keyword_length = 2 },
		signature = { enabled = false, window = { show_documentation = false } },
		cmdline = {
			enabled = true,
			keymap = {
				preset = 'super-tab',
				['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },
				['<C-p>'] = { 'show', 'select_prev', 'fallback_to_mappings' },
			},
			completion = {
				menu = {
					auto_show = true,
					draw = { columns = { { 'label', 'label_description', gap = 1 } } },
				},
			},
		},
		completion = {
			list = { selection = { auto_insert = false, preselect = true } },
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
					columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
				},
				border = vim.g.winborder,
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 500,
			},
		},
	}

	require('blink.cmp').setup(opts)
end)
