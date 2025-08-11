---@diagnostic disable:undefined-field

local Plugin = { 'oskarrrrrrr/symbols.nvim' }

Plugin.keys = {
	{ '<leader>ls', desc = 'Toggle Symbols(focus)' },
	{ '<leader>lS', desc = 'Toggle Symbols' },
}

function Plugin.config()
	local r = require('symbols.recipes')
	require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {
		sidebar = {
			hide_cursor = true,
			open_direction = 'right',
			show_guide_lines = false,
			show_inline_details = false,
			chars = {
				folded = '▸',
				unfolded = '▾',
				guide_vert = '│',
				guide_middle_item = '├',
				guide_last_item = '└',
				-- use this highlight group for the guide lines
				hl = 'Comment',
			},
			auto_resize = {
				min_width = 30,
				max_width = 60,
			},
			keymaps = {
				['<right>'] = 'toggle-fold',
				['<left>'] = 'toggle-fold',
				['+'] = 'toggle-fold',
				['-'] = 'toggle-fold',
				['<space>'] = 'toggle-fold',
			},
		},
	})
	vim.keymap.set('n', '<leader>ls', '<cmd> SymbolsToggle<CR>', { desc = 'Toggle Symbols(focus)' })
	vim.keymap.set('n', '<leader>lS', '<cmd> SymbolsToggle!<CR>', { desc = 'Toggle Symbols' })
end

return Plugin
