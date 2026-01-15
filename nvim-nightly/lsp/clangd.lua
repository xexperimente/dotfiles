return {
	cmd = {
		jit.os:find('Windows')
				and 'C:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/Llvm/x64/bin/clangd.exe'
			or 'clangd',
	},
	filetypes = { 'c', 'cpp', 'h', 'hpp', 'ixx' },
	root_markers = {
		'.clangd',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json',
		'compile_flags.txt',
		-- 'configure.ac', -- GNU Autotools.
	},
	reuse_client = function(client, config) return client.name == config.name end,
	settings = {
		clangd = {
			Completion = {
				CodePatterns = 'NONE',
			},
		},
	},
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
				completionItem = {
					snippetSupport = false,
				},
			},
		},
		-- Off-spec, but clangd and vim.lsp support UTF-8, which is more efficient.
		offsetEncoding = { 'utf-8', 'utf-16' },
	},
	on_init = function(client, init_result)
		if init_result.offsetEncoding then client.offset_encoding = init_result.offsetEncoding end
	end,

	-- Assumes at most one clangd client is attached to a buffer.
	on_attach = function(_client, _buf)
		-- vim.api.nvim_buf_create_user_command(buf, 'ClangdSwitchSourceHeader', function()
		--   switch_source_header(client, buf)
		-- end, {
		--   bar = true,
		--   desc = 'clangd: Switch Between Source and Header File',
		-- })
		-- vim.keymap.set('n', 'grs', '<Cmd>ClangdSwitchSourceHeader<CR>', {
		--   buffer = buf,
		--   desc = 'clangd: Switch Between Source and Header File',
		-- })
		--
		-- vim.api.nvim_create_autocmd('LspDetach', {
		--   group = vim.api.nvim_create_augroup('conf_lsp_attach_detach', { clear = false }),
		--   buffer = buf,
		--   callback = function(args)
		--     if args.data.client_id == client.id then
		--       vim.keymap.del('n', 'grs', { buffer = buf })
		--       vim.api.nvim_buf_del_user_command(buf, 'ClangdSwitchSourceHeader')
		--       return true -- Delete this autocmd.
		--     end
		--   end,
		-- })
	end,
} --[[@as vim.lsp.Config]]
