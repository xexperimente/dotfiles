vim.lsp.enable({
	"emmylua_ls",
})

vim.diagnostic.config({
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	float = {
		border = "single",
	},
})
