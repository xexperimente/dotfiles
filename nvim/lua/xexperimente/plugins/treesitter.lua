local Plugin = { 'nvim-treesitter/nvim-treesitter' }

Plugin.event = 'VeryLazy'

Plugin.dependencies = {
	'nvim-treesitter/nvim-treesitter-textobjects',
}

Plugin.opts = {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { 'html' },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<C-up>',
			node_incremental = '<C-up>',
			scope_incremental = false,
			node_decremental = '<C-down>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
				['ia'] = '@parameter.inner',
			},
		},
		swap = {
			enable = true,
			swap_previous = {
				['{a'] = '@parameter.inner',
			},
			swap_next = {
				['}a'] = '@parameter.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']f'] = '@function.outer',
				[']c'] = '@class.outer',
				[']a'] = '@parameter.inner',
			},
			goto_next_end = {
				[']F'] = '@function.outer',
				[']C'] = '@class.outer',
			},
			goto_previous_start = {
				['[f'] = '@function.outer',
				['[c'] = '@class.outer',
				['[a'] = '@parameter.inner',
			},
			goto_previous_end = {
				['[F'] = '@function.outer',
				['[C'] = '@class.outer',
			},
		},
	},
	ensure_installed = {
		'toml',
		'yaml',
		'comment',
		'json',
		'lua',
		'vimdoc',
		'vim',
	},
}

Plugin.keys = {
	{ '<c-up>', desc = 'Increment selection' },
	{ '<c-down>', desc = 'Decrement selection' },
}

Plugin.cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' }

Plugin.build = ':TSUpdate'

function Plugin.config(_, opts)
	require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'cl' }
	require('nvim-treesitter.configs').setup(opts)
end

return Plugin
