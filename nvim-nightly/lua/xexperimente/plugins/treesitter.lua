local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = 'main' } end

vim.pack.add({
	gh('nvim-treesitter/nvim-treesitter'),
	gh('nvim-treesitter/nvim-treesitter-textobjects'),
})

local ts = require('nvim-treesitter')

ts.install({ 'bash', 'rust', 'regex', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline', 'zig', 'nu' })

require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			['@class.outer'] = '<c-v>', -- blockwise
		},
		include_surrounding_whitespace = false,
	},
})

vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'Handle nvim-treesitter updates',
	group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
	callback = function(event)
		if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
			vim.notify('nvim-treesitter: updating languages', vim.log.levels.INFO)
			ts.update()
		end
	end,
})

local sel = require('nvim-treesitter-textobjects.select')
local swap = require('nvim-treesitter-textobjects.swap')

vim.keymap.set({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'as', function() sel.select_textobject('@local.scope', 'locals') end)
vim.keymap.set('n', '<leader>x', function() swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>X', function() swap.swap_previous('@parameter.outer') end)
