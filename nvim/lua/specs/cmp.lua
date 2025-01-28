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
}

return Plugin
