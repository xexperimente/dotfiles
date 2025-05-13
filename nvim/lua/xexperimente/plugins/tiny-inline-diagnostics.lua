local Plugin = { 'rachartier/tiny-inline-diagnostic.nvim' }

Plugin.event = 'VeryLazy'

Plugin.opts = {
	preset = 'powerline',
	options = {
		show_source = true,
		show_all_diags_on_cursorline = true,
		multilines = {
			enabled = true,
			always_show = false, -- show only current line diagnostics
		},
	},
	hi = {
		background = 'Norma',
	},
}

return Plugin
