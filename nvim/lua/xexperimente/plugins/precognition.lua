local Plugin = { 'tris203/precognition.nvim' }

Plugin.event = { 'VeryLazy' }

Plugin.opts = {
	startVisible = false,
}

Plugin.keys = {
	{ '<leader>up', '<cmd>Precognition toggle<cr>', desc = 'Toggle Precognition' },
}

return Plugin
