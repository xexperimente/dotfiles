vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(event)
			local lsp = vim.lsp.buf
			local bind = vim.keymap.set

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method('textDocument/foldingRange') then
				local win = vim.api.nvim_get_current_win()
				vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
				vim.wo[win][0].foldtext = 'v:lua.vim.lsp.foldtext()'
			end

			local opts = { silent = true, buffer = event.buf }

			bind({ 'n', 'i' }, '<C-h>', lsp.signature_help, opts)

			bind('n', 'gd', ':lua Snacks.picker.lsp_definitions()<cr>', opts)
			bind('n', 'gD', ':lua Snacks.picker.lsp_declarations()<cr>', opts)
			bind('n', 'gy', ':lua Snacks.picker.lsp_type_definitions()<cr>', opts)
			bind('n', 'gY', lsp.typehierarchy, opts)
			bind('n', 'grr', ':lua Snacks.picker.lsp_references()<cr>', opts)
			bind('n', 'gri', ':lua Snacks.picker.lsp_implementations()<cr>', opts)
			bind('n', 'grn', lsp.rename, opts)
			bind('n', 'gra', lsp.code_action, opts)
			bind('n', 'gO', lsp.document_symbol, opts)
			bind('n', 'gs', lsp.signature_help, opts)
			bind('n', '<F2>', lsp.rename, opts)
			bind('n', '<F4>', lsp.code_action, opts)
			bind('n', '<F12>', ':lua Snacks.picker.lsp_definitions()<cr>', opts)

			bind('n', '<C-W>d', vim.diagnostic.open_float, opts)
			bind('n', '<leader>lf', vim.diagnostic.open_float, opts)

			bind('n', '<leader>lp', ':lua Snacks.picker.diagnostics_buffer()<cr>', opts)
			bind('n', '<leader>lP', ':lua Snacks.picker.diagnostics()<cr>', opts)
			bind('n', '<leader>ld', ':lua Snacks.picker.lsp_symbols()<cr>', opts)
			bind('n', '<leader>lD', ':lua Snacks.picker.lsp_workspace_symbols()<cr>', opts)

			-- MiniClue.set_mapping_desc('n', '<leader>lp', 'Show diagnostics[current]')
			-- MiniClue.set_mapping_desc('n', '<leader>lP', 'Show diagnostics[all]')
			-- MiniClue.set_mapping_desc('n', '<leader>ld', 'Show symbols')
			-- MiniClue.set_mapping_desc('n', '<leader>lD', 'Show workspace symbols')
			-- MiniClue.set_mapping_desc('n', '<leader>lf', 'Open diagnostic window')
			-- MiniClue.set_mapping_desc('n', 'gd', 'Go definition')
			-- MiniClue.set_mapping_desc('n', 'gD', 'Go declaration')
			-- MiniClue.set_mapping_desc('n', 'gri', 'Go implementation')
			-- MiniClue.set_mapping_desc('n', 'grn', 'Rename symbol')
			-- MiniClue.set_mapping_desc('n', 'grr', 'Show references')
			-- MiniClue.set_mapping_desc('n', 'gra', 'Code action')
			-- MiniClue.set_mapping_desc('n', 'gy', 'Show type definition')
			-- MiniClue.set_mapping_desc('n', 'gs', 'Signature help')
			-- MiniClue.set_mapping_desc('n', 'gO', 'Document symbol')

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = "user-lsp-highlight",
						buffer = event2.buf,
					})
				end,
			})
		end
	end,
})
