-- Show context of the current function
local Plugin = {
	'nvim-treesitter/nvim-treesitter-context',
}
Plugin.cond = true
Plugin.event = { 'WinScrolled', 'CursorMoved', 'BufReadPre' }

Plugin.opts = {
	enable = true,
	mode = 'cursor',
	max_lines = 3,
	separator = nil, -- '⎯',
}

return Plugin
