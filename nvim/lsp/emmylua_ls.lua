--- @type vim.lsp.Config
local result = {

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
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'jit',
					'Snacks',
					'MiniSplitjoin',
				},
				disable = { 'unnecessary-if' },
			},
			codelens = {
				enable = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('data') .. '/site/pack/core/opt',
				},
			},
		},
	},
}

return result
