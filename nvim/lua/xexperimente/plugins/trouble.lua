local Plugin = { 'folke/trouble.nvim' }

Plugin.opts = {
	auto_close = true,
}

Plugin.keys = {
	{ '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
	{ '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
}

return Plugin
