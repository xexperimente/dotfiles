-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = {
-- 		'json',
-- 		'jsonc',
-- 		'astro',
-- 		'yaml',
-- 	},
-- 	callback = function()
-- 		-- find the root dir
-- 		local root_file = vim.fs.find({ 'biome.json' }, {
-- 			path = vim.fn.expand('%:p:h'),
-- 			upward = true,
-- 		})[1]
--
-- 		local root_dir = vim.fs.dirname(root_file)
--
-- 		vim.lsp.start({
-- 			name = 'biome',
-- 			cmd = { 'biome', 'lsp-proxy' },
-- 			root_dir = root_dir,
-- 			single_file_support = true,
-- 		})
-- 	end,
-- })

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { '*.md', '*.jsonc', '*.json' },
	callback = function()
		vim.notify('Biome formatting')
		vim.lsp.buf.format({
			async = false,
			-- Pokud máte v projektu spuštěno více LSP (např. vtsls i biome),
			-- tímto filtrem zajistíte, že formátování provede výhradně Biome:
			-- filter = function(client) return client.name == 'biome' end,
		})
	end,
})

---@type vim.lsp.Config
return {
	cmd = { 'biome', 'lsp-proxy' },
	filetypes = {
		'astro',
		'css',
		'json',
		'jsonc',
		'vue',
		'yaml',
	},
	workspace_required = false,
	root_markers = { 'biome.json', 'biome.jsonc', '.git' },
	settings = {},
}
