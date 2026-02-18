local clue = require('mini.clue')

local opts = {
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },

		-- Customs
		{ mode = 'n', keys = ']' },
		{ mode = 'n', keys = '[' },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		clue.gen_clues.windows(),
		clue.gen_clues.z(),
		-- Custom clues
		{ mode = 'n', keys = '<leader>f', desc = 'Find ' },
		{ mode = 'n', keys = '<leader>g', desc = 'Git ' },
		{ mode = 'n', keys = '<leader>b', desc = 'Buffers ' },
		{ mode = 'n', keys = '<leader>p', desc = 'Plugins ' },
		{ mode = 'n', keys = '<leader>u', desc = 'Options ' },
		{ mode = 'n', keys = '<leader>s', desc = 'Search ' },
		{ mode = 'n', keys = '<leader>c', desc = 'Code ' },
		{ mode = 'n', keys = 'zu', desc = 'Undo spelling command ' },
	},
	window = {
		config = {
			width = 'auto',
			border = 'single',
		},
	},
}

clue.setup(opts)
