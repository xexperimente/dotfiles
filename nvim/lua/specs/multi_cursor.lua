-- Multicursor
local Plugin = { 'mg979/vim-visual-multi' }

Plugin.branch = 'master'

Plugin.lazy = false

function Plugin.init()
	vim.g.VM_maps = {
		['Find Under'] = '<M-C-d>',
		['Find Subword Under'] = '<C-d>',
		['Select Cursor Down'] = '<M-C-Down>',
		['Select Cursor Up'] = '<M-C-Up>',
	}
end

return Plugin
