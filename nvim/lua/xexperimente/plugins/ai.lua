local Plugin = { 'exafunction/codeium.vim' }

Plugin.event = 'BufEnter'

function Plugin.config()
	vim.g.codeium_manual = true

	local bind = vim.keymap.set

	bind('i', '<M-a>', function() return vim.fn['codeium#Accept']() end, { expr = true })
	bind('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
end

return Plugin
