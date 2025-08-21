vim.lsp.enable({
	'emmylua_ls',
	-- 'lua-ls',
})

vim.diagnostic.config({
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '󰌵',
			[vim.diagnostic.severity.INFO] = '',
		},
	},
	float = {
		border = 'single',
	},
})

local autocmd = vim.api.nvim_create_autocmd
local bind = vim.keymap.set

autocmd('LspAttach', {
	callback = function()
		bind('n', '<f2>', 'grn', { desc = 'Rename symbol' })
		bind('n', '<f4>', 'gra', { desc = 'Code Action' })
		bind('n', '<f12>', 'gD', { desc = 'Go to declaration' })
		bind('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	end,
})
