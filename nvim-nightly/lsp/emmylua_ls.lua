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
					'jit',
				},
				disable = {},
			},
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
					vim.fn.stdpath('data') .. '/site/pack/core/opt/',
				}),
			},
		},
	},
}
