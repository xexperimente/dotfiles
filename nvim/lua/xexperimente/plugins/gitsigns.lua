local Plugin = { 'lewis6991/gitsigns.nvim' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

Plugin.opts = {
	current_line_blame = true,
	current_line_blame_formatter = '    <author> • <author_time:%R> • <summary>',
}

return Plugin
