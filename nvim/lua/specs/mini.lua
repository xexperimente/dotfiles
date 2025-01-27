local Plugin = { 'echasnovski/mini.nvim' }
local user = {}

Plugin.lazy = true
Plugin.version = false
Plugin.event = 'VeryLazy'

function Plugin.config()
	require('mini.ai').setup({})

	-- Cycle various locations (diagnostics, buffers, etc.)
	require('mini.bracketed').setup({ n_lines = 500 })

	-- Add/Delete/Replace surroundings (brackets, quotes, etc.)
	require('mini.surround').setup()

	-- Delete buffers
	require('mini.bufremove').setup()

	-- Highlight word under cursor
	require('mini.cursorword').setup()

	-- Highlight current block scope
	require('mini.indentscope').setup()

	-- Split/Join
	require('mini.splitjoin').setup()

	require('mini.extra').setup()

	require('mini.comment').setup()

	require('mini.icons').setup()

	local clue = require('mini.clue')

	clue.setup({
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
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
			-- Custom clues
			{ mode = 'n', keys = '<leader>f', desc = 'Pick ' },
			{ mode = 'n', keys = '<Leader>g', desc = 'Git ' },
			{ mode = 'n', keys = '<Leader>b', desc = 'Buffers ' },
			{ mode = 'n', keys = '<Leader>p', desc = 'Plugins ' },
			{ mode = 'n', keys = '<Leader>u', desc = 'Options ' },
			{ mode = 'n', keys = '<Leader>v', desc = 'Visual ' },
			{ mode = 'n', keys = '<Leader>l', desc = 'LSP ' },
			{ mode = 'n', keys = 'zu', desc = 'Undo spelling command ' },
		},
		window = {
			config = {
				width = 'auto',
				border = require('user.env').border,
			},
		},
	})

	require('mini.git').setup()
	require('mini.diff').setup({
		view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } },
	})

	user.setup_diff_summary()
end

function user.setup_diff_summary()
	local format_summary = function(data)
		local summary = vim.b[data.buf].minidiff_summary

		if summary == nil then return end

		local t = {}
		if summary.add > 0 then table.insert(t, ' ' .. summary.add) end
		if summary.change > 0 then table.insert(t, ' ' .. summary.change) end -- 
		if summary.delete > 0 then table.insert(t, ' ' .. summary.delete) end
		vim.b[data.buf].minidiff_summary_string = table.concat(t, ' ')
	end

	vim.api.nvim_create_autocmd('User', { pattern = 'MiniDiffUpdated', callback = format_summary })
end

Plugin.keys = {
	-- Mini.Bufremove
	{ '<leader>bd', ':lua MiniBufremove.delete()<cr>', desc = 'Delete Buffer' },

	-- Mini.Splitjoin
	{ '<leader>uj', ':lua MiniSplitjoin.toggle()<cr>', desc = 'Toggle MiniSplitjoin' },

	-- Mini.Surround
	{ 'sa' },
	{ 'sd' },

	-- Mini.Diff
	{ '<leader>gc', ':lua MiniDiff.toggle_overlay()<cr>', desc = 'Toogle git changes overlay' },
}

return Plugin
