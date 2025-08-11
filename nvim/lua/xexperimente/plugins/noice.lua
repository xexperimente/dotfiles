local Plugin = { 'folke/noice.nvim' }

Plugin.event = 'VeryLazy'

Plugin.opts = {
	presets = {
		bottom_search = false,
		lsp_doc_border = false,
	},
	lsp = {
		progress = { enabled = false },
		signature = { enabled = false },
	},
	views = {
		cmdline_popup = {
			position = {
				row = '70%',
				col = '50%',
			},
			border = {
				style = 'single',
			},
		},
	},
	popupmenu = { enabled = false },
	notify = { enabled = false },
}

Plugin.dependencies = {
	-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	'MunifTanjim/nui.nvim',
	-- OPTIONAL:
	--   `nvim-notify` is only needed, if you want to use the notification view.
	--   If not available, we use `mini` as the fallback
	-- "rcarriga/nvim-notify",
}
return Plugin
