-- Autocompletion
local Plugin = { 'saghen/blink.cmp' }

Plugin.version = 'v0.*'
Plugin.event = { 'InsertEnter', 'CmdlineEnter' }
Plugin.opts = {
	completion = {
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
		-- documentation = {
		-- 	auto_show = true,
		-- 	auto_show_delay_ms = 0,
		-- },
		menu = {
			draw = {
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind' },
					{ 'kind_icon' },
				},
			},
			border = require('user.env').cmp_border,
		},
	},
	signature = { enabled = true },
	cmdline = {
		enabled = true,
		completion = { menu = { auto_show = true } },
		sources = function()
			local type = vim.fn.getcmdtype()
			-- Search forward and backward
			if type == '/' or type == '?' then return { 'buffer' } end
			-- Commands
			if type == ':' or type == '@' then return { 'cmdline', 'path' } end
			return {}
		end,
		keymap = {
			preset = 'enter',
			['<cr>'] = { 'accept_and_enter', 'fallback' },
			['<C-y>'] = { 'accept', 'fallback' },
		},
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
