-- Enable LSPs
vim.lsp.enable({
	'emmylua_ls',
	-- 'lua-ls',
	'zls',
	'rust_analyzer',
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

vim.api.nvim_create_user_command('LspLog', function() vim.cmd.tabnew(vim.lsp.log.get_filename()) end, {})

local autocmd = vim.api.nvim_create_autocmd
local bind = vim.keymap.set
local augroup = vim.api.nvim_create_augroup('LspCommands', {})

-- Disable LSP in diff mode
autocmd('BufEnter', {
	group = augroup,
	callback = function(_) vim.diagnostic.enable(not vim.opt.diff:get()) end,
})

autocmd('LspAttach', {
	group = augroup,
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then return end

		-- if client:supports_method(vim.lsp.protocol.Methods.textDocument_diagnostics) then vim.cmd('redrawstatus') end
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

		bind('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Go to definition' })
		bind('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Go to declaration' })
		bind('n', 'grr', function() Snacks.picker.lsp_references() end, { desc = 'Go to references' })
		bind('n', 'gri', function() Snacks.picker.lsp_implementations() end, { desc = 'Go to implementation' })
		bind('n', 'grt', function() Snacks.picker.lsp_type_definition() end, { desc = 'Go to type definition' })
		bind('n', '<f2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
		bind('n', '<f4>', function() vim.lsp.buf.code_action() end, { desc = 'Code Action' })
		bind('v', '<f4>', function() vim.lsp.buf.code_action() end, { desc = 'Code Action' })
		bind('n', '<f12>', function() Snacks.picker.lsp_definitions() end, { desc = 'Go to definition' })
		bind('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	end,
})
