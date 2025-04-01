local Plugin = { 'saghen/blink.cmp' }

Plugin.version = '*'

Plugin.event = { 'InsertEnter', 'CmdlineEnter' }

Plugin.opts = {
	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		accept = { auto_brackets = { enabled = false } },
		documentation = { auto_show = false },
		menu = {
			enabled = true,
			auto_show = true,
			draw = {
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind' },
					{ 'kind_icon' },
				},
			},
			border = 'rounded',
		},
		trigger = { show_in_snippet = false },
	},
	signature = { enabled = true, window = { show_documentation = false } },
	cmdline = {
		enabled = true,
		completion = {
			menu = {
				auto_show = function(_)
					return vim.fn.getcmdtype() == ':' -- or '@' for inputs
				end,
			},
			ghost_text = { enabled = true },
		},
		keymap = {
			preset = 'enter',
			['<cr>'] = { 'accept_and_enter', 'fallback' },
			['<C-y>'] = { 'accept', 'fallback' },
			['<Tab>'] = { 'show', 'accept' },
		},
		sources = function()
			local type = vim.fn.getcmdtype()
			-- Search forward and backward
			if type == '/' or type == '?' then return { 'buffer' } end
			-- Commands
			if type == ':' or type == '@' then return { 'cmdline', 'path' } end
			return {}
		end,
	},
	sources = {
		providers = {
			path = {
				opts = {
					get_cwd = function(_) return vim.fn.getcwd() end,
				},
			},
		},
		min_keyword_length = function(ctx)
			-- only applies when typing a command, doesn't apply to arguments
			if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
			return 0
		end,
	},
}

return Plugin
