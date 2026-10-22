local add_on_event = require('pack').add_on_event

-- Better text objects.
add_on_event('BufReadPre', {
	{
		src = 'nvim-treesitter/nvim-treesitter-textobjects',
		setup = false,
	},
	{
		src = 'nvim-mini/mini.ai',
		opts = function()
			local miniai = require('mini.ai').gen_spec

			return {
				n_lines = 300,
				custom_textobjects = {
					f = miniai.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
					c = miniai.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
					s = miniai.treesitter({ a = '@local.scope', i = '@local.scope' }, {}),
					a = miniai.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }, {}),
					o = miniai.treesitter({ a = '@loop.outer', i = '@loop.inner' }, {}),
				},
				-- Disable error feedback.
				silent = true,
				-- Don't use the previous or next text object.
				search_method = 'cover',
				mappings = {
					-- Disable next/last variants.
					around_next = '',
					inside_next = '',
					around_last = '',
					inside_last = '',
				},
			}
		end,
		on_setup = function()
			local swap = require('nvim-treesitter-textobjects.swap')
			local move = require('nvim-treesitter-textobjects.move')
			local bind = vim.keymap.set

			-- swap
			bind('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
			bind('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)

			-- move
			bind({ 'n', 'x', 'o' }, ']z', function() move.goto_next_start('@fold', 'folds') end)
			bind({ 'n', 'x', 'o' }, '[z', function() move.goto_previous_start('@fold', 'folds') end)
			bind({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
			bind({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end)
		end,
	},
})
