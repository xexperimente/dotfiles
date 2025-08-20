return {
	cmd = { 'emmylua_ls' },
	filetypes = { 'lua' },
	root_markers = {
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
					vim.fn.stdpath('data') .. '/lazy',
					'luvit-meta/library',
					vim.fn.stdpath('data') .. '/mason/packages/lua-language-server/meta/3rd/luv',
				},
			},
		},
	},
}
