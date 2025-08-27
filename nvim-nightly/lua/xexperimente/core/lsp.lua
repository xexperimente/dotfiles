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
	group = vim.api.nvim_create_augroup('LspCommands', {}),
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then return end

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_diagnostics) then vim.cmd('redrawstatus') end
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
			vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
			vim.lsp.inline_completion()

			bind('i', '<Tab>', function()
				if not vim.lsp.inline_completion.get() then return '<tab>' end
			end, {
				expr = true,
				replace_keycodes = true,
				desc = 'Get current inline completion',
			})
		end

		bind('n', '<f2>', 'grn', { desc = 'Rename symbol' })
		bind('n', '<f4>', 'gra', { desc = 'Code Action' })
		bind('n', '<f12>', 'gD', { desc = 'Go to declaration' })
		bind('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	end,
})
