local Plugin = { 'williamboman/mason.nvim' }

Plugin.lazy = true

Plugin.cmd = { 'Mason', 'MasonUpdate' }

Plugin.opts = {
	ui = { border = 'rounded' },
}

return Plugin
