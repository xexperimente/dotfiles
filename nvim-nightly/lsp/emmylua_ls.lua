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
					-- 'Snacks',
					-- 'MiniStatusline',
					-- 'MiniClue',
				},
				disable = {
					'inject-field',
					-- 'undefined-field',
				},
			},
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('data') .. '/site/pack/core/opt/',
					vim.env.HOME .. '/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/luv',
				},
			},
		},
	},
}
