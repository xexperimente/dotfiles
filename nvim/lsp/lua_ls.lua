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
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath('config')
				and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				enable = true,
				globals = { 'Snacks' },
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
				ignoreDir = { '**/test/**', '**/tests/**', '**/spec/**', '**/.git/**', '**/doc/**' },
			},
			telemetry = { enable = false },
		})
	end,
	settings = { Lua = {} },
}
