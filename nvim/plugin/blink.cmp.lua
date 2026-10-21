local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'saghen/blink.lib',
		setup = false,
	},
	{
		src = 'saghen/blink.cmp',
		opts = {
			fuzzy = { implementation = 'prefer_rust' },
			keymap = {
				preset = 'super-tab',
				['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },
				['<C-d>'] = { 'show_documentation', 'hide_documentation' },
			},
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, min_keyword_length = 2 },
			signature = { enabled = true, window = { show_documentation = false } },
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
				list = { selection = { auto_insert = false } },
				menu = {
					auto_show = true,
					draw = {
						treesitter = { 'lsp' },
						columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
					},
				},
				documentation = { auto_show = false },
			},
		},
		on_setup = function()
			-- TODO: Fix the Task type below.
			---@diagnostic disable-next-line: undefined-field
			require('blink.cmp').build():pwait()
		end,
	},
})
