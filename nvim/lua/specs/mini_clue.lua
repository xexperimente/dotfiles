local Plugin = { 'echasnovski/mini.clue' }

Plugin.version = false

Plugin.priority = 1

Plugin.event = 'VeryLazy'

function Plugin.opts()
	local miniclue = require('mini.clue')

	return {
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
			-- { mode = 'n', keys = ']' },
			-- { mode = 'n', keys = '[' },
		},

		clues = {
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
			-- Custom clues
			{ mode = 'n', keys = '<leader>f', desc = '+Pick' },
			{ mode = 'n', keys = '<Leader>l', desc = '+LSP' },
			{ mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
			{ mode = 'n', keys = '<Leader>p', desc = '+Plugins' },
		},
		window = {
			config = {
				border = require('user.env').border,
			},
		},
	}
end

return Plugin
