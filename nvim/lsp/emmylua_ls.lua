--- Get lib paths for input packages.
--- @param pkgs string[]
local function plugins(pkgs)
	for p, pkg in ipairs(pkgs) do
		pkgs[p] = vim.fn.stdpath('data') .. '/site/pack/core/opt/' .. pkg
	end
	return unpack(pkgs)
end

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
			diagnostics = {
				globals = {
					'vim',
					'jit',
					'Snacks',
				},
				disable = { 'unnecessary-if' },
			},
			codelens = {
				enable = true,
			},
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME .. '/lua',
					vim.env.VIMRUNTIME .. '/plugin',
					plugins({ 'snacks.nvim', 'mini.nvim' }),
				},
			},
		},
	},
}

return result
