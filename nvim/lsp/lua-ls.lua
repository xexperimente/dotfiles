---@type vim.lsp.Config
return {
	cmd = { 'lua-language-server' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
		'.git',
	},
	filetypes = { 'lua' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				enable = false,
				disable = { 'lowercase-global' },
			},
			hint = {
				enable = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
