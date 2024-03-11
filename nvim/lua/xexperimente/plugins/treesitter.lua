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
			init_selection = '<C-space>',
			node_incremental = '<C-space>',
			scope_incremental = false,
			node_decremental = '<bs>',
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
		-- 'javascript',
		'toml',
		-- 'yaml',
		'comment',
		-- 'php',
		-- 'html',
		-- 'css',
		'json',
		'lua',
	},
}

Plugin.keys = {
	{ '<c-space>', desc = 'Increment selection' },
}

Plugin.cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' }

Plugin.build = ':TSUpdate'

-- function Plugin.build()
-- 	--pcall(vim.cmd, 'TSUpdate')
-- 	vim.cmd('TSUpdate')
-- end

function Plugin.config(_, opts)
	require('nvim-treesitter.install').compilers = { 'clang' }
	require('nvim-treesitter.configs').setup(opts)
end

return Plugin
