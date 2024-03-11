local Plugins = {}
local Plug = function(spec) table.insert(Plugins, spec) end

-- Toggle comment on line or block
Plug({
	'echasnovski/mini.comment',
	version = false,
	config = true,
	event = { 'BufRead', 'BufNewFile' },
})

-- surround selections
Plug({
	'echasnovski/mini.surround',
	version = false,
	config = true,
	opts = {
		mappings = {
			add = '<leader>sa',
			delete = '<leader>sd',
		},
	},
	event = { 'BufRead', 'BufNewFile' },
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

-- TODO: mini.sessions
-- TODO: mini.starter

return Plugins
