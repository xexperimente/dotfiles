local Plugin = { 'tris203/precognition.nvim' }
local user = {}

Plugin.event = 'VeryLazy'

Plugin.opts = {
	startVisible = false,
}

Plugin.keys = {
	{ '<leader>h', function() user.toggle() end },
}

function user.toggle()
	if require('precognition').toggle() then
		vim.notify('Precognition on')
	else
		vim.notify('Precognition off')
	end
end

return Plugin
