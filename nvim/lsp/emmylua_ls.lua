--- @type vim.lsp.Config
local result = {
	cmd = { 'emmylua_ls' },
	filetypes = { 'lua' },
	root_markers = {
		'.emmyrc.json',
		'stylua.toml',
		'selene.toml',
		'.git',
	},
	workspace_required = true,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = {
				globals = {
					'Snacks',
				},
				disable = { 'unnecessary-if' },
			},
			codelens = { enable = true },
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('data') .. '/site/pack/core/opt',
				},
				ignoreGlobs = { '**/test/**', '**/tests/**', '**/spec/**', '**/.git/**', '**/doc/**' },
				checkThirdParty = false,
			},
		},
	},
}

return result
