local Plugin = { 'VonHeikemen/lsp-zero.nvim' }

Plugin.branch = 'v3.x'

Plugin.lazy = true

Plugin.config = false
function Plugin.init()
	-- Disable automatic setup, we are doing it manually
	vim.g.lsp_zero_extend_cmp = 0
	vim.g.lsp_zero_extend_lspconfig = 0
end

return Plugin
