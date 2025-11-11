--- Get lib paths for input packages.
--- @param pkgs string[]
local function libs(pkgs)
	for p, pkg in ipairs(pkgs) do
		pkgs[p] = vim.fn.stdpath('data') .. '/site/pack/core/opt/' .. pkg
	end
	return pkgs
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
				disable = {},
			},
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				-- library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
				-- 	vim.fn.stdpath('data') .. '/site/pack/core/opt/',
				-- }),
				library = {
					vim.env.VIMRUNTIME .. '/lua',
					vim.env.VIMRUNTIME .. '/plugin',
					unpack(libs({
						'flash.nvim',
						'mini.nvim',
						'nvim-treesitter',
						'nvim-treesitter-textobjects',
						'witch-line',
						'snacks.nvim',
					})),
				},
			},
		},
	},
}

return result
