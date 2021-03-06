local Plugin = { 'lewis6991/gitsigns.nvim' }

Plugin.event = 'VeryLazy'

Plugin.opts = {
	current_line_blame = true,
	current_line_blame_formatter = '    <author> • <author_time:%R> • <summary>',
}
Plugin.config = true

return Plugin
