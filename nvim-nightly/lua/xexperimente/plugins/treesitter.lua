local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = 'main' } end

vim.pack.add({
	gh('nvim-treesitter/nvim-treesitter'),
	gh('nvim-treesitter/nvim-treesitter-textobjects'),
})

local ts = require('nvim-treesitter')

ts.install({ 'regex', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline' })

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

local sel = require('nvim-treesitter-textobjects.select')
local swap = require('nvim-treesitter-textobjects.swap')

vim.keymap.set({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'as', function() sel.select_textobject('@local.scope', 'locals') end)
vim.keymap.set('n', '<leader>x', function() swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>X', function() swap.swap_previous('@parameter.outer') end)

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('TreesitterCommands', { clear = true })

autocmd('PackChanged', {
	group = augroup,
	pattern = { 'nvim-treesitter' },
	callback = function(_event)
		-- if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
		vim.notify('Updating treesitter parsers', vim.log.levels.INFO)
		ts.update(nil, { summary = true })
		-- end
	end,
})

autocmd('FileType', {
	group = augroup,
	pattern = { '*' },
	callback = function(event)
		local filetype = event.match
		local lang = vim.treesitter.language.get_lang(filetype)
		local is_installed, _error = vim.treesitter.language.add(lang)

		if not is_installed then
			local available_langs = ts.get_available()
			local is_available = vim.tbl_contains(available_langs, lang)

			-- TODO: confirmation dialog

			if is_available then
				vim.notify('Installing treesitter parser for ' .. lang, vim.log.levels.INFO)
				ts.install({ lang }):wait(30 * 1000)
			end
		end

		local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
		if not ok then return end

		--
		-- vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end,
})
