vim.schedule(function()
	vim.lsp.config('*', {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	})

	vim.lsp.enable({
		'emmylua_ls',
		'clangd',
		-- 'lua-ls',
		-- 'zls',
		-- 'rust_analyzer',
	})

	if vim.fn.has('win32') == 1 then vim.lsp.enable('nushell') end

	local signs = require('icons').diagnostics
	local hl_map = {
		[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
		[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
		[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
		[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
	}

	vim.diagnostic.config({
		underline = true,
		update_in_insert = false,
		signs = { text = signs },
		float = { border = vim.g.winborder },
		virtual_text = {
			spacing = 4,
			source = 'if_many',
			prefix = ' ●',
			suffix = ' ',
		},
		status = {
			format = function(counts)
				local items = {}
				for level, _ in ipairs(vim.diagnostic.severity) do
					local count = counts[level] or 0
					if count > 0 then table.insert(items, ('%%#%s#%s %s'):format(hl_map[level], signs[level], count)) end
				end
				return table.concat(items, ' ')
			end,
		},
	})

	local usercmd = vim.api.nvim_create_user_command
	usercmd('LspLog', function() vim.cmd.tabnew(vim.lsp.log.get_filename()) end, {})
	usercmd('LspInfo', function() vim.cmd('checkhealth vim.lsp') end, {})

	local autocmd = vim.api.nvim_create_autocmd
	local bind = vim.keymap.set
	local augroup = vim.api.nvim_create_augroup('xexperimente/lsp-commands', {})

	-- Disable LSP in diff mode
	autocmd('BufEnter', {
		group = augroup,
		callback = function() vim.diagnostic.enable(not vim.opt.diff:get()) end,
	})

	autocmd('LspAttach', {
		group = augroup,
		callback = function(event)
			local id = vim.tbl_get(event, 'data', 'client_id')
			local client = id and vim.lsp.get_client_by_id(id)
			if client == nil then return end

			if client:supports_method('textDocument/inlineCompletion') then
				vim.opt.completeopt = 'menu,menuone,noinsert,fuzzy,popup'
				vim.lsp.inline_completion.enable(true)

				bind('i', '<Tab>', function()
					if not vim.lsp.inline_completion.get() then return '<tab>' end
				end, {
					expr = true,
					replace_keycodes = true,
					desc = 'Get current inline completion',
				})
			end

			if client:supports_method('textDocument/codeLens') then
				vim.lsp.codelens.enable(true)

				autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
					buffer = event.buf,
					callback = function() vim.lsp.codelens.enable(true, { bufnr = event.buf }) end,
				})

				bind({ 'n', 'x' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
				bind('n', '<leader>cC', function() vim.lsp.codelens.enable(true) end, { desc = 'Refresh Codelens' })
			end

			if client:supports_method('textDocument/codeAction') then
				bind({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
				bind({ 'n', 'x' }, '<f4>', vim.lsp.buf.code_action, { desc = 'Code Action' })
			end

			if client:supports_method('textDocument/hover') then
				bind('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
			end

			if client:supports_method('textDocument/rename') then
				bind('n', '<f2>', vim.lsp.buf.rename, { desc = 'Rename' })
				bind('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
			end

			if client:supports_method('textDocument/diagnostic') then
				bind('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
			end
		end,
	})
end)
