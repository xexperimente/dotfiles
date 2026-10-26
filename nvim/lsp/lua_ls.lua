---@type vim.lsp.Config
return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.stylua.toml',
		'.git',
	},
	-- NOTE: These will be merged with the configuration file.
	settings = {
		Lua = {
			completion = { callSnippet = 'Replace' },
			-- Using stylua for formatting.
			format = { enable = false },
			hint = { enable = true, arrayIndex = 'Disable' },
			diagnostics = { enable = true, globals = { 'Snacks' } },
			codelens = { enable = true },
			signatureHelp = { enable = true },
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('data') .. '/site/pack/core/opt',
				},
				ignoreDir = { '**/test/**', '**/tests/**', '**/spec/**', '**/.git/**', '**/doc/**' },
			},
			telemetry = { enable = false },
		},
	},
}
