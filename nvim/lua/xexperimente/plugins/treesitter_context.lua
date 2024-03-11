-- Show context of the current function
local Plugin = {
	'nvim-treesitter/nvim-treesitter-context',
}

Plugin.event = { 'WinScrolled', 'CursorMoved', 'BufReadPre' }

Plugin.opts = {
	enable = true,
	mode = 'cursor',
	max_lines = 3,
	separator = '⎯',
}

function Plugin.init()
	vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'Normal' })
	vim.api.nvim_set_hl(0, 'TreesitterContextSeparator', { link = 'LspFloatWinBorder' })
end

return Plugin
