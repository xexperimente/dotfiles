local add_on_event = require('pack').add_on_event
local bind = vim.keymap.set

add_on_event('UIEnter', {
	{
		src = 'nvim-treesitter/nvim-treesitter',
		version = 'main',
		-- data = { after = 'TSUpdate' },
		on_setup = function()
			-- Main-branch nvim-treesitter ships queries under `runtime/queries/`,
			-- which isn't on rtp by default. Prepend it so highlights/folds/indents
			-- are visible to `vim.treesitter.start`.
			local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
			if init then vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime') end
		end,
	},
	{
		src = 'nvim-treesitter/nvim-treesitter-context',
		module_name = 'treesitter-context',
		opts = {
			-- Avoid the sticky context from growing a lot.
			max_lines = 3,
			-- Match the context lines to the source code.
			multiline_threshold = 1,
			-- Disable it when the window is too small.
			min_window_height = 20,
			-- Nicer separator
			separator = '',
		},
		on_setup = function() bind('n', '<leader>uc', '<cmd>TSContext toggle<cr>', { desc = 'Toggle treesitter context' }) end,
	},
	-- {
	-- 	src = 'nvim-treesitter/nvim-treesitter-textobjects',
	-- 	version = 'main',
	-- 	opts = {
	-- 		select = {
	-- 			lookahead = true,
	-- 			selection_modes = {
	-- 				['@parameter.outer'] = 'v', -- charwise
	-- 				['@function.outer'] = 'V', -- linewise
	-- 				['@class.outer'] = '<c-v>', -- blockwise
	-- 			},
	-- 			include_surrounding_whitespace = false,
	-- 		},
	-- 	},
	-- 	on_setup = function()
	-- 		local sel = require('nvim-treesitter-textobjects.select')
	-- 		local swap = require('nvim-treesitter-textobjects.swap')
	-- 		local move = require('nvim-treesitter-textobjects.move')
	--
	-- 		-- select keybinds
	-- 		bind({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer', 'textobjects') end)
	-- 		bind({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner', 'textobjects') end)
	-- 		bind({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer', 'textobjects') end)
	-- 		bind({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner', 'textobjects') end)
	-- 		bind({ 'x', 'o' }, 'as', function() sel.select_textobject('@local.scope', 'locals') end)
	--
	-- 		-- swap
	-- 		bind('n', '<leader>x', function() swap.swap_next('@parameter.inner') end)
	-- 		bind('n', '<leader>X', function() swap.swap_previous('@parameter.outer') end)
	--
	-- 		-- move
	-- 		bind({ 'n', 'x', 'o' }, ']z', function() move.goto_next_start('@fold', 'folds') end)
	-- 		bind({ 'n', 'x', 'o' }, '[z', function() move.goto_previous_start('@fold', 'folds') end)
	-- 	end,
	-- },
})

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(args)
		if args.data.spec.name == 'nvim-treesitter' and (args.data.kind == 'install' or args.data.kind == 'update') then
			require('nvim-treesitter').update():wait(300000)
		end
	end,
})
