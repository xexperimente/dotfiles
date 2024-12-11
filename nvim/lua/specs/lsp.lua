-- LSP support
local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.lazy = true

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

Plugin.dependencies = {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'echasnovski/mini.nvim' },
}

function Plugin.config()
	user.ui()
	user.diagnostics()

	user.lsp_attach()

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities =
		vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					['hint.enable'] = true,
					['diagnostics.enable'] = false,
					completion = {
						callSnippet = 'Replace',
					},
				},
			},
		},
	}

	require('mason').setup()

	require('mason-lspconfig').setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}

				server.capabilities =
					vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

				require('lspconfig')[server_name].setup(server)
			end,
		},
	})

	require('lspconfig').rust_analyzer.setup({})
end

function user.lsp_attach()
	local group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
	local autocmd = vim.api.nvim_create_autocmd

	autocmd('LspAttach', {
		group = group,
		callback = function(event)
			local lsp = vim.lsp.buf
			local bind = vim.keymap.set
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			-- local command = vim.api.nvim_buf_create_user_command

			-- command(0, 'LspFormat', function(input) vim.lsp.buf.format({ async = input.bang }) end, {})

			local opts = { silent = true, buffer = event.buf }

			-- bind({ 'n', 'x' }, 'gq', ':LspFormat!<cr>', opts)
			bind({ 'n', 'i' }, '<C-h>', lsp.signature_help, opts)

			bind('n', 'K', lsp.hover, opts)
			bind('n', 'gd', ':lua MiniExtra.pickers.lsp({ scope="definition" })<cr>', opts)
			bind('n', 'gD', ':lua MiniExtra.pickers.lsp({ scope="declaration" })<cr>', opts)
			bind('n', 'gi', ':lua MiniExtra.pickers.lsp({ scope="implementation" })<cr>', opts)
			bind('n', 'go', ':lua MiniExtra.pickers.lsp({ scope="type_definition" })<cr>', opts)
			bind('n', 'gr', ':lua MiniExtra.pickers.lsp({ scope="references" })<cr>', opts)
			bind('n', 'gs', lsp.signature_help, opts)
			bind('n', 'crn', lsp.rename, opts)
			bind('n', 'crr', lsp.code_action, opts)
			bind('n', '<F2>', lsp.rename, opts)
			bind('n', '<F4>', lsp.code_action, opts)
			bind('n', '<F12>', ':lua MiniExtra.pickers.lsp({ scope="definition" })<cr>', opts)

			bind('n', '<C-W>d', vim.diagnostic.open_float, opts)
			bind('n', '[d', vim.diagnostic.goto_prev, opts)
			bind('n', ']d', vim.diagnostic.goto_next, opts)

			bind('n', '<leader>lp', ':lua MiniExtra.pickers.diagnostic({ scope=current })<cr>', opts)
			bind('n', '<leader>lP', ':lua MiniExtra.pickers.diagnostic({ scope=all })<cr>', opts)
			bind('n', '<leader>ld', ':lua MiniExtra.pickers.lsp({ scope="document_symbol" })<cr>', opts)
			bind('n', '<leader>lD', ':lua MiniExtra.pickers.lsp({ scope="workspace_symbol" })<cr>', opts)

			if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				bind('n', 'gh', user.toggle_inlay_hints, opts)
			end

			MiniClue.set_mapping_desc('n', '<leader>lp', 'Show diagnostics[current]')
			MiniClue.set_mapping_desc('n', '<leader>lP', 'Show diagnostics[all]')
			MiniClue.set_mapping_desc('n', '<leader>ld', 'Show symbols')
			MiniClue.set_mapping_desc('n', '<leader>lD', 'Show workspace symbols')
			MiniClue.set_mapping_desc('n', 'gh', 'Toggle inlay hints')
			MiniClue.set_mapping_desc('n', 'gd', 'Go definition')
			MiniClue.set_mapping_desc('n', 'gD', 'Go declaration')
			MiniClue.set_mapping_desc('n', 'gi', 'Go implementation')
			MiniClue.set_mapping_desc('n', 'go', 'Show type definition')
			MiniClue.set_mapping_desc('n', 'gr', 'Show references')
			MiniClue.set_mapping_desc('n', 'gs', 'Signature help')
		end,
	})
end

function user.toggle_inlay_hints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end

function user.diagnostics()
	vim.diagnostic.config({
		virtual_text = {
			source = 'if_many',
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '',
				[vim.diagnostic.severity.HINT] = '',
				[vim.diagnostic.severity.INFO] = '',
			},
		},
	})

	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	local group = augroup('UserDiagnosticCmds', { clear = true })

	autocmd('ModeChanged', {
		group = group,
		pattern = { 'n:i', 'v:s' },
		desc = 'Disable diagnostics while typing',
		callback = function(e) vim.diagnostic.disable(e.bufnr) end,
	})

	autocmd('ModeChanged', {
		group = group,
		pattern = 'i:n',
		desc = 'Enable diagnostics when leaving insert mode',
		callback = function(e) vim.diagnostic.enable(e.bufnr) end,
	})
end

function user.ui()
	-- Border and color for LspInfo
	require('lspconfig.ui.windows').default_options = {
		border = require('user.env').border,
	}
end

-- function Plugin.init()
-- 	disable lsp semantic highlights
-- 	vim.api.nvim_create_autocmd('ColorScheme', {
-- 		desc = 'Clear LSP highlight groups',
-- 		callback = function()
-- 			local higroups = vim.fn.getcompletion('@lsp', 'highlight')
-- 			for _, name in ipairs(higroups) do
-- 				vim.api.nvim_set_hl(0, name, {})
-- 			end
-- 		end,
-- 	})
-- end

return Plugin
