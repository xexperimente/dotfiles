-- Multicursor
--TODO: local Plugin = { 'brenton-leighton/multiple-cursors.nvim' }

local Plugin = { 'mg979/vim-visual-multi' }

Plugin.branch = 'master'
Plugin.lazy = false

-- Plugin.event = { 'BufEnter', 'VeryLazy' }

Plugin.keys = {
	{ '<C-n>' },
	{ '<C-M-n>' },
	{ '<C-M-up>' },
	{ '<C-M-down>' },
}

function Plugin.init()
	vim.g.VM_maps = {
		-- ['Find Under'] = '<C-n>',
		['Find Subword Under'] = '<C-M-n>',
		['Select Cursor Down'] = '<C-M-down>',
		['Select Cursor Up'] = '<C-M-up>',
	}
	vim.g.VM_highlight_matches = ''
end

return Plugin
