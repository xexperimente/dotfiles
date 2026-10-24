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
})

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(args)
		if args.data.spec.name == 'nvim-treesitter' and (args.data.kind == 'install' or args.data.kind == 'update') then
			---@diagnostic disable-next-line: undefined-field
			require('nvim-treesitter').update():wait(300000)
		end
	end,
})
