local Plugin = { 'folke/ts-comments.nvim' }

Plugin.opts = {
	lang = {
		nu = '# %s',
	},
}

Plugin.event = 'VeryLazy'

Plugin.enabled = vim.fn.has('nvim-0.10.0') == 1

return Plugin
