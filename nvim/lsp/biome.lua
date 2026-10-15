vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { '*.md', '*.jsonc', '*.json' },
	callback = function(ev)
		vim.lsp.buf.format({
			async = false,
			buffer = ev.buf,
			filter = function(client) return client.name == 'biome' end,
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
		'yaml',
		'markdown',
	},
	workspace_required = false,
	root_markers = { 'biome.json', 'biome.jsonc' },
	settings = {},
}
