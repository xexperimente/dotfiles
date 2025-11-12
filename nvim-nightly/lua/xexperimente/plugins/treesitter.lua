local function gh(pkg, data)
	if data == nil then data = {} end
	return {
		src = 'https://github.com/' .. pkg,
		version = 'main',
		data = data,
	}
end

vim.pack.add({
	gh('nvim-treesitter/nvim-treesitter', { after = 'TSUpdate' }),
	gh('nvim-treesitter/nvim-treesitter-textobjects'),
	'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

-- local ts = require('nvim-treesitter')

-- ts.install({ 'regex', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline' })

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

require('treesitter-context').setup({
	max_lines = 3,
	separator = '',
})

local bind = vim.keymap.set
local sel = require('nvim-treesitter-textobjects.select')
local swap = require('nvim-treesitter-textobjects.swap')
local move = require('nvim-treesitter-textobjects.move')

-- select keybinds
bind({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer', 'textobjects') end)
bind({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner', 'textobjects') end)
bind({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer', 'textobjects') end)
bind({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner', 'textobjects') end)
bind({ 'x', 'o' }, 'as', function() sel.select_textobject('@local.scope', 'locals') end)
-- swap
bind('n', '<leader>x', function() swap.swap_next('@parameter.inner') end)
bind('n', '<leader>X', function() swap.swap_previous('@parameter.outer') end)
-- move
bind({ 'n', 'x', 'o' }, ']z', function() move.goto_next_start('@fold', 'folds') end)
bind({ 'n', 'x', 'o' }, '[z', function() move.goto_previous_start('@fold', 'folds') end)
-- context
bind('n', '<leader>uc', '<cmd>TSContext toggle<cr>', { desc = 'Toggle treesitter context' })

-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup('TreesitterCommands', { clear = true })

-- autocmd('FileType', {
-- 	group = augroup,
-- 	pattern = { '*' },
-- 	callback = function(event)
-- 		local filetype = event.match
-- 		local lang = vim.treesitter.language.get_lang(filetype)
-- 		local is_installed, _error = vim.treesitter.language.add(lang)
--
-- 		if not is_installed then
-- 			local available_langs = ts.get_available()
-- 			local is_available = vim.tbl_contains(available_langs, lang)
--
-- 			-- TODO: confirmation dialog
--
-- 			if is_available then
-- 				vim.notify('Installing treesitter parser for ' .. lang, vim.log.levels.INFO)
-- 				ts.install({ lang }):wait(30 * 1000)
-- 			end
-- 		end
--
-- 		local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
-- 		if not ok then return end
--
-- 		--
-- 		-- vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- 	end,
-- })
