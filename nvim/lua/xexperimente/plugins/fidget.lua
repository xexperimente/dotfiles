local Plugin = { 'j-hui/fidget.nvim' }

Plugin.opts = {
	progress = {
		ignore_done_already = true,
		display = {
			render_limit = 10,
			done_icon = 'done',
		},
	},
}

Plugin.config = true

return Plugin
