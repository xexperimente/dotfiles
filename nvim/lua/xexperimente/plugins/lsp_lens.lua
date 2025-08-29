-- LSP lenses - show definitions and references of symbol
-- replace candidate https://github.com/Wansmer/symbol-usage.nvim
local Plugin = { 'vidocqh/lsp-lens.nvim' }

Plugin.event = { 'BufRead', 'BufNewFile' }
Plugin.cmd = { 'LspLensOn', 'LspLensOff', 'LspLensToggle' }

Plugin.opts = {
	include_declaration = true,
	sections = {
		definition = false,
		git_authors = function(latest_author, count)
			return latest_author .. (count - 1 == 0 and '' or (' + ' .. count - 1))
		end,
	},
}

return Plugin
