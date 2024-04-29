local Plugin = { 'williamboman/mason.nvim' }

Plugin.lazy = true

Plugin.cmd = { 'Mason', 'MasonUpdate' }

Plugin.opts = {
	ui = { border = require('user.env').border },
}

return Plugin
