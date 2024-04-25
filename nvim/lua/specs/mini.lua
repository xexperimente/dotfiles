local Plugins = {}
local Plug = function(spec) table.insert(Plugins, spec) end

Plug({
	'JoosepAlviste/nvim-ts-context-commentstring',
	main = 'ts_context_commentstring',
	lazy = true,
	opts = {
		enable_autocmd = false,
	},
	init = function() vim.g.skip_ts_context_commentstring_module = true end,
})

-- Toggle comment on line or block
Plug({
	'echasnovski/mini.comment',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
	opts = {
		options = {
			custom_commentstring = function()
				local cs = require('ts_context_commentstring').calculate_commentstring()
				return cs or vim.bo.commentstring
			end,
		},
	},
})

Plug({
	'echasnovski/mini.bufremove',
	version = false,
	main = 'mini.bufremove',
	config = true,
	keys = { { '<leader>bd', '<cmd>lua pcall(MiniBufremove.delete)<cr>' } },
})

Plug({
	'echasnovski/mini.bracketed',
	version = false,
	main = 'mini.bracketed',
	keys = {
		{ '[g', "<cmd>lua MiniBracketed.conflict('backward')<cr>", mode = { 'n', 'x' } },
		{ ']g', "<cmd>lua MiniBracketed.conflict('forward')<cr>", mode = { 'n', 'x' } },

		{ '[q', "<cmd>lua MiniBracketed.quickfix('backward')<cr>" },
		{ ']q', "<cmd>lua MiniBracketed.quickfix('forward')<cr>" },
	},
	opts = {
		buffer = { suffix = '' },
		comment = { suffix = '' },
		conflict = { suffix = '' },
		diagnostic = { suffix = '' },
		file = { suffix = '' },
		indent = { suffix = '' },
		jump = { suffix = '' },
		location = { suffix = '' },
		oldfile = { suffix = '' },
		quickfix = { suffix = '' },
		treesitter = { suffix = '' },
		undo = { suffix = '' },
		window = { suffix = '' },
		yank = { suffix = '' },
	},
})

-- surround selections
Plug({
	'echasnovski/mini.surround',
	version = false,
	lazy = true,
	config = true,
	opts = {
		mappings = {
			add = '<leader>sa',
			delete = '<leader>sd',
		},
	},
	keys = {
		'<leader>sa',
		'<leader>sd',
	},
})

-- Highlight all occurences of current word
Plug({
	'echasnovski/mini.cursorword',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.indentscope',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.splitjoin',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

Plug({
	'echasnovski/mini.notify',
	lazy = true,
	event = 'VeryLazy',
	version = false,
	opts = {
		lsp_progress = {
			enable = false,
		},
	},
	init = function()
		vim.notify = function(...)
			local notify = require('mini.notify').make_notify()
			vim.notify = notify
			return notify(...)
		end

		vim.keymap.set('n', '<leader><space>', function()
			vim.cmd("echo ''")
			require('mini.notify').clear()
		end)
	end,
})

-- TODO: mini.sessions
-- TODO: mini.starter

return Plugins