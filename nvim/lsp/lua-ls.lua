---@type vim.lsp.Config
return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
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
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				enable = true,
				globals = {
					'vim',
					'jit',
					'Snacks',
				},
				disable = { 'lowercase-global' },
			},
			hint = {
				enable = true,
			},
			codelens = {
				enable = true,
			},
			signatureHelp = {
				enable = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('data') .. '/site/pack/core/opt',
				},
				ignoreDir = {
					'**/test/**',
					'**/tests/**',
					'**/spec/**',
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
