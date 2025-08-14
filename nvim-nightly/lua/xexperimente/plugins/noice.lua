
local function gh(pkg)
	return { src = "https://github.com/" .. pkg, version = vim.version.range("*") }
end

vim.pack.add({
	gh("folke/noice.nvim"),
	gh("MunifTanjim/nui.nvim"),
})

require("noice").setup({
	presets = {
		bottom_search = false,
		lsp_doc_border = false,
	},
	lsp = {
		progress = { enabled = false },
		signature = { enabled = false },
	},
	views = {
		cmdline_popup = {
			position = {
				row = '70%',
				col = '50%',
			},
			border = {
				style = 'single',
			},
		},
	},
	popupmenu = { enabled = false },
	notify = { enabled = false },
})
