
local Plugin = { 'tris203/precognition.nvim' }
local user = {}

Plugin.event = {'BufEnter', 'BufNew'}

Plugin.opts = {
	startVisible = false,
}

Plugin.keys = {
	{ '<leader>up', function() user.toggle() end, desc = 'Toggle Precognition' },
}

function user.toggle()
	if require('precognition').toggle() then
		vim.notify('Precognition on')
	else
		vim.notify('Precognition off')
	end
end

return Plugin
