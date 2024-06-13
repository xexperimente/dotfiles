local Plugin = { 'echasnovski/mini.nvim' }

local user = {}

Plugin.dependencies = {
	{ 'carbon-steel/detour.nvim' },
}

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

	require('mini.indentscope').setup()

	require('mini.splitjoin').setup()

	require('mini.extra').setup()

	require('mini.notify').setup({
		lsp_progress = {
			enable = false,
		},
	})

	require('mini.pick').setup({
		window = {
			config = {
				border = require('user.env').border,
				anchor = 'NW',
				height = 30,
				width = 80,
				row = math.floor(0.5 * (vim.o.lines - 30)),
				col = math.floor(0.5 * (vim.o.columns - 80)),
			},
			max_width_share = 0.7,
		},
	})

	vim.ui.select = require('mini.pick').ui_select

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
			-- { mode = 'n', keys = ']' },
			-- { mode = 'n', keys = '[' },
		},

		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
			-- Custom clues
			{ mode = 'n', keys = '<leader>f', desc = '+Pick' },
			{ mode = 'n', keys = '<Leader>g', desc = '+Git' },
			{ mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
			{ mode = 'n', keys = '<Leader>p', desc = '+Plugins' },
		},
		window = {
			config = {
				border = require('user.env').border,
			},
		},
	})

	require('mini.diff').setup()
end

Plugin.keys = {
	-- Mini.Bufremove
	{ '<leader>bd', ':lua MiniBufremove.delete()<cr>', desc = 'Delete Buffer' },

	-- Mini.Pick
	{ '<leader>fb', ':Pick buffers<cr>', desc = 'Open buffers' },
	{ '<leader>ff', ':Pick files<cr>', desc = 'Find files' },
	{ '<leader>fg', ':Pick grep_live<cr>', desc = 'Live grep' },
	{ '<leader>fc', ':Pick hl_groups<cr>', desc = 'Find colors' },
	{ '<leader>fh', ':Pick help<cr>', desc = 'Find in help' },
	{ '<leader>fk', ':lua MiniExtra.pickers.keymaps()<cr>', desc = 'Keymap' },
	{ '<leader>fo', ':Pick oldfiles<cr>', desc = 'Recent files' },
	{ '<leader>fG', ':Pick grep<cr>', desc = 'Grep string' },
	{ '<leader>fs', ':Pick treesitter<cr>', desc = 'Buffer symbols' },
	{ '<leader>fr', ':Pick resume<cr>', desc = 'Resume last search' },
	{ '<leader>fm', ':Pick marks<cr>', desc = 'Show marks' },
	{ '<leader>fH', ':lua MiniExtra.pickers.history()<cr>', desc = 'History' },
	{ '<leader>gl', ':lua MiniExtra.pickers.git_commits()<cr>', desc = 'Git commits' },
	{ '<leader>gb', ':lua MiniExtra.pickers.git_branches()<cr>', desc = 'Git branches' },

	-- Mini.Surround
	{ 'sa' },
	{ 'sd' },

	-- Mini.Notify
	{ '<leader>o', function() user.show_history() end, desc = 'Show history' },
	{ '<leader><space>', function() user.cls() end, desc = 'Clear' },

	-- Mini.Diff
	{ '<leader>gc', ':lua MiniDiff.toggle_overlay()<cr>', desc = 'Toogle git changes overlay' },
}

function user.show_history()
	local bind = vim.keymap.set
	local feedkeys = vim.api.nvim_feedkeys
	local rtc = vim.api.nvim_replace_termcodes('<c-w><c-q>', true, true, true)

	require('detour').Detour()

	require('mini.notify').show_history()

	bind('n', '<esc>', function() feedkeys(rtc, 'n', true) end, { buffer = true })
	bind('n', 'q', function() feedkeys(rtc, 'n', true) end, { buffer = true })
end

function user.cls()
	vim.cmd("echo ''")
	require('mini.notify').clear()
end

-- function Plugin.init()
-- vim.notify = function(...)
-- 	local notify = require('mini.notify').make_notify()
-- 	vim.notify = notify
-- 	return notify(...)
-- end
-- end

return Plugin

-- local Plugins = {}
-- local Plug = function(spec) table.insert(Plugins, spec) end
--
-- Plug({
-- 	'echasnovski/mini.bufremove',
-- 	version = false,
-- 	main = 'mini.bufremove',
-- 	lazy = true,
-- 	event = 'VeryLazy',
-- 	config = true,
-- 	keys = { { '<leader>bd', '<cmd>lua pcall(MiniBufremove.delete)<cr>' } },
-- })
--
-- Plug({
-- 	'echasnovski/mini.bracketed',
-- 	version = false,
-- 	main = 'mini.bracketed',
-- 	lazy = true,
-- 	event = 'VeryLazy',
-- 	config = true,
-- })
--
-- -- surround selections
-- Plug({
-- 	'echasnovski/mini.surround',
-- 	version = false,
-- 	lazy = true,
-- 	config = true,
-- 	keys = {
-- 		'sa',
-- 		'sd',
-- 	},
-- })
--
-- -- Highlight all occurences of current word
-- Plug({
-- 	'echasnovski/mini.cursorword',
-- 	version = false,
-- 	config = true,
-- 	event = { 'BufRead', 'BufNewFile' },
-- })
--
-- Plug({
-- 	'echasnovski/mini.indentscope',
-- 	version = false,
-- 	config = true,
-- 	event = { 'BufRead', 'BufNewFile' },
-- })
--
-- Plug({
-- 	'echasnovski/mini.splitjoin',
-- 	version = false,
-- 	config = true,
-- 	event = { 'BufRead', 'BufNewFile' },
-- })
--
-- Plug({
-- 	'echasnovski/mini.notify',
-- 	lazy = true,
-- 	event = 'VeryLazy',
-- 	version = false,
-- 	opts = {
-- 		lsp_progress = {
-- 			enable = false,
-- 		},
-- 	},
-- 	dependencies = { 'carbon-steel/detour.nvim' },
-- 	init = function()
-- 		vim.notify = function(...)
-- 			local notify = require('mini.notify').make_notify()
-- 			vim.notify = notify
-- 			return notify(...)
-- 		end
--
-- 		vim.keymap.set('n', '<leader><space>', function()
-- 			vim.cmd("echo ''")
-- 			require('mini.notify').clear()
-- 		end, { desc = 'Clear notifications' })
--
-- 		vim.keymap.set('n', '<leader>o', function()
-- 			require('detour').Detour()
--
-- 			require('mini.notify').show_history()
--
-- 			vim.keymap.set(
-- 				'n',
-- 				'<esc>',
-- 				function()
-- 					vim.api.nvim_feedkeys(
-- 						vim.api.nvim_replace_termcodes('<c-w><c-q>', true, true, true),
-- 						'n',
-- 						true
-- 					)
-- 				end,
-- 				{ desc = 'Close notify history', buffer = true }
-- 			)
--
-- 			vim.keymap.set(
-- 				'n',
-- 				'q',
-- 				function()
-- 					vim.api.nvim_feedkeys(
-- 						vim.api.nvim_replace_termcodes('<c-w><c-q>', true, true, true),
-- 						'n',
-- 						true
-- 					)
-- 				end,
-- 				{ desc = 'Close notify history', buffer = true }
-- 			)
-- 		end, { desc = 'Show notification history' })
-- 	end,
-- })
--
-- local win_config = function()
-- 	local height = math.floor(0.618 * vim.o.lines)
-- 	local width = math.floor(0.618 * vim.o.columns)
-- 	return {
-- 		border = require('user.env').border,
-- 		anchor = 'NW',
-- 		height = height,
-- 		width = width,
-- 		row = math.floor(0.5 * (vim.o.lines - height)),
-- 		col = math.floor(0.5 * (vim.o.columns - width)),
-- 	}
-- end
--
-- Plug({
-- 	'echasnovski/mini.extra',
-- 	version = false,
-- 	main = 'mini.extra',
-- 	lazy = false,
-- 	config = true,
-- })
--
-- Plug({
-- 	'echasnovski/mini.pick',
-- 	version = false,
-- 	main = 'mini.pick',
-- 	lazy = true,
-- 	opts = {
-- 		window = {
-- 			config = win_config,
-- 			-- prompt_prefix = '> ',
-- 		},
-- 	},
-- 	keys = {
-- 		{ '<leader>fb', '<cmd>Pick buffers<cr>', { desc = 'Open buffers' } },
-- 		{ '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Find files' } },
-- 		{ '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' } },
-- 		{ '<leader>fc', '<cmd>Pick hl_groups<cr>', { desc = 'Find colors' } },
-- 		{ '<leader>fh', '<cmd>Pick help<cr>', { desc = 'Find in help' } },
-- 		{ '<leader>fk', '<cmd>lua MiniExtra.pickers.keymaps()<cr>', { desc = 'Keymap' } },
-- 		{ '<leader>fo', '<cmd>Pick oldfiles<cr>', { desc = 'Recent files' } },
-- 		{ '<leader>fG', '<cmd>Pick grep<cr>', { desc = 'Grep string' } },
-- 		{ '<leader>fs', '<cmd>Pick treesitter<cr>', { desc = 'Buffer symbols' } },
-- 		{ '<leader>fr', '<cmd>Pick resume<cr>', { desc = 'Resume last search' } },
-- 		{ '<leader>fm', '<cmd>Pick marks<cr>', { desc = 'Show marks' } },
--
-- 		{ '<leader>fH', '<cmd>lua MiniExtra.pickers.history()<cr>', { desc = 'History' } },
--
-- 		{ '<leader>gl', '<cmd>lua MiniExtra.pickers.git_commits()<cr>', { desc = 'Git commits' } },
-- 		{
-- 			'<leader>gb',
-- 			'<cmd>lua MiniExtra.pickers.git_branches()<cr>',
-- 			{ desc = 'Git branches' },
-- 		},
-- 	},
-- })
--
-- -- TODO: mini.sessions
-- -- TODO: mini.starter
--
-- return Plugins
