local Plugin = {"rachartier/tiny-inline-diagnostic.nvim"}

Plugin.event = "VeryLazy"

Plugin.opts = {
	options = {
		show_source = true,
		show_all_diags_on_cursorline = true,
		multilines = {
			enabled = true,
			always_show = true,
		},
	},
}

return Plugin
