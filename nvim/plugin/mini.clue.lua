local add_on_event = require('pack').add_on_event

-- Remember my mappings.
add_on_event('UIEnter', {
	{
		src = 'nvim-mini/mini.clue',
		opts = function()
			local miniclue = require('mini.clue')

			return {
				triggers = {
					-- Builtins.
					{ mode = { 'n', 'x' }, keys = 'g' },
					{ mode = { 'n', 'x' }, keys = '`' },
					{ mode = { 'n', 'x' }, keys = '"' },
					{ mode = { 'i', 'c' }, keys = '<C-r>' },
					{ mode = 'n', keys = '<C-w>' },
					{ mode = 'i', keys = '<C-x>' },
					{ mode = 'n', keys = 'z' },
					{ mode = 'n', keys = 'Z' },
					-- Leader triggers.
					{ mode = { 'n', 'x' }, keys = '<leader>' },
					-- Moving between stuff.
					{ mode = 'n', keys = '[' },
					{ mode = 'n', keys = ']' },
				},
				clues = {
					-- Leader/movement groups.
					-- { mode = { 'n', 'x' }, keys = '<leader>a', desc = '+ai' },
					{ mode = { 'n', 'x' }, keys = '<leader>c', desc = 'Code' },
					{ mode = { 'n', 'x' }, keys = '<leader>f', desc = 'Find' },
					{ mode = 'n', keys = '<leader>b', desc = 'Buffers' },
					{ mode = 'n', keys = '<leader>d', desc = 'Debug' },
					{ mode = 'n', keys = '<leader>p', desc = 'Plugins' },
					{ mode = 'n', keys = '<leader>t', desc = 'Tabs' },
					{ mode = 'n', keys = '<leader>x', desc = 'Loclist/Quickfix' },
					{ mode = 'n', keys = '[', desc = 'Prev' },
					{ mode = 'n', keys = ']', desc = 'Next' },
					{ mode = 'n', keys = 'zu', desc = 'Undo spelling command' },
					{ mode = 'n', keys = 'ZZ', desc = 'Save and close' },
					{ mode = 'n', keys = 'ZR', desc = 'Restart' },
					{ mode = 'n', keys = 'ZQ', desc = 'Force quit' },
					-- Builtins.
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
				window = {
					delay = 500,
					scroll_down = '<C-f>',
					scroll_up = '<C-b>',
					config = function(bufnr)
						local max_width = 0
						for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
							max_width = math.max(max_width, vim.fn.strchars(line))
						end

						-- Keep some right padding.
						max_width = max_width + 2

						return {
							border = vim.g.winborder,
							-- Dynamic width capped at 70.
							width = math.min(70, max_width),
						}
					end,
				},
			}
		end,
	},
})
-- vim.defer_fn(function()
-- 	vim.pack.add({ 'https://github.com/nvim-mini/mini.clue' })
-- 	local clue = require('mini.clue')
--
-- 	local opts = {
-- 		triggers = {
-- 			-- Leader triggers
-- 			{ mode = 'n', keys = '<Leader>' },
-- 			{ mode = 'x', keys = '<Leader>' },
--
-- 			-- Built-in completion
-- 			{ mode = 'i', keys = '<C-x>' },
--
-- 			-- `g` key
-- 			{ mode = 'n', keys = 'g' },
-- 			{ mode = 'x', keys = 'g' },
--
-- 			-- Marks
-- 			{ mode = 'n', keys = "'" },
-- 			{ mode = 'n', keys = '`' },
-- 			{ mode = 'x', keys = "'" },
-- 			{ mode = 'x', keys = '`' },
--
-- 			-- Registers
-- 			{ mode = 'n', keys = '"' },
-- 			{ mode = 'x', keys = '"' },
-- 			{ mode = 'i', keys = '<C-r>' },
-- 			{ mode = 'c', keys = '<C-r>' },
--
-- 			-- Window commands
-- 			{ mode = 'n', keys = '<C-w>' },
--
-- 			-- `z` key
-- 			{ mode = 'n', keys = 'z' },
-- 			{ mode = 'n', keys = 'Z' },
-- 			{ mode = 'x', keys = 'z' },
--
-- 			-- Customs
-- 			{ mode = 'n', keys = ']' },
-- 			{ mode = 'n', keys = '[' },
-- 		},
--
-- 		clues = {
-- 			-- Enhance this by adding descriptions for <Leader> mapping groups
-- 			clue.gen_clues.builtin_completion(),
-- 			clue.gen_clues.g(),
-- 			clue.gen_clues.marks(),
-- 			clue.gen_clues.registers(),
-- 			clue.gen_clues.windows(),
-- 			clue.gen_clues.z(),
-- 			-- Custom clues
-- 			{ mode = 'n', keys = '<leader>f', desc = 'Find ' },
-- 			{ mode = 'n', keys = '<leader>g', desc = 'Git ' },
-- 			{ mode = 'n', keys = '<leader>b', desc = 'Buffers ' },
-- 			{ mode = 'n', keys = '<leader>p', desc = 'Plugins ' },
-- 			{ mode = 'n', keys = '<leader>u', desc = 'Options ' },
-- 			{ mode = 'n', keys = '<leader>s', desc = 'Search ' },
-- 			{ mode = 'n', keys = '<leader>c', desc = 'Code ' },
-- 			{ mode = 'n', keys = 'zu', desc = 'Undo spelling command ' },
-- 			{ mode = 'n', keys = 'ZZ', desc = 'Save and close' },
-- 			{ mode = 'n', keys = 'ZR', desc = 'Restart' },
-- 			{ mode = 'n', keys = 'ZQ', desc = 'Force quit' },
-- 		},
-- 		window = {
-- 			config = {
-- 				width = 'auto',
-- 				border = vim.g.winborder,
-- 			},
-- 		},
-- 	}
--
-- 	clue.setup(opts)
-- end, 0)
