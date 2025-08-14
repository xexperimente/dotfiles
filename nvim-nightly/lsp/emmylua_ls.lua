return {
	cmd = { 'emmylua_ls' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.emmyrc.json',
		'stylua.toml',
		'selene.toml',
		'.git',
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					'vim',
					'Snacks',
					'MiniStatusline',
					'MiniClue',
				},
				disable = {
					'inject-field',
					-- 'undefined-field',
				},
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					-- vim.fn.stdpath('data') .. '/lazy/lazy.nvim',
					-- vim.fn.stdpath('data') .. '/lazy/mini.nvim',
					-- vim.fn.stdpath('data') .. '/lazy/snacks.nvim',
					-- vim.fn.stdpath('data') .. '/lazy',
					-- 'luvit-meta/library',
				},
			},
		},
	},
}
