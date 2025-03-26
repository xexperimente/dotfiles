-- LSP support
local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.lazy = true

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

Plugin.dependencies = {
	{ 'saghen/blink.cmp' },
	{ 'williamboman/mason-lspconfig.nvim' },
}

function Plugin.config()
	user.diagnostics()
	user.lsp_attach()

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					['hint.enable'] = true,
					['diagnostics.enable'] = false,
					completion = {
						callSnippet = 'Replace',
					},
					typeDefinition = {
						dynamicRegistration = true,
						linkSupport = true,
					},
					typeHierarchy = {
						dynamicRegistration = true,
					},
				},
			},
		},
		zls = {
			enable_build_on_save = true,
		},
	}

	require('mason').setup()

	require('mason-lspconfig').setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}

				server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
				require('lspconfig')[server_name].setup(server)
			end,
		},
	})

	-- require('lspconfig').rust_analyzer.setup({})
	require('lspconfig').zls.setup({})
end

function user.lsp_attach()
	local group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
	local autocmd = vim.api.nvim_create_autocmd

	autocmd('LspAttach', {
		group = group,
		callback = function(event)
			local lsp = vim.lsp.buf
			local bind = vim.keymap.set
			-- local client = vim.lsp.get_client_by_id(event.data.client_id)

			local opts = { silent = true, buffer = event.buf }

			bind({ 'n', 'i' }, '<C-h>', lsp.signature_help, opts)

			bind('n', 'K', lsp.hover, opts)
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

			MiniClue.set_mapping_desc('n', '<leader>lp', 'Show diagnostics[current]')
			MiniClue.set_mapping_desc('n', '<leader>lP', 'Show diagnostics[all]')
			MiniClue.set_mapping_desc('n', '<leader>ld', 'Show symbols')
			MiniClue.set_mapping_desc('n', '<leader>lD', 'Show workspace symbols')
			MiniClue.set_mapping_desc('n', 'gd', 'Go definition')
			MiniClue.set_mapping_desc('n', 'gD', 'Go declaration')
			MiniClue.set_mapping_desc('n', 'gri', 'Go implementation')
			MiniClue.set_mapping_desc('n', 'grn', 'Rename symbol')
			MiniClue.set_mapping_desc('n', 'grr', 'Show references')
			MiniClue.set_mapping_desc('n', 'gra', 'Code action')
			MiniClue.set_mapping_desc('n', 'gy', 'Show type definition')
			MiniClue.set_mapping_desc('n', 'gs', 'Signature help')
			MiniClue.set_mapping_desc('n', 'gO', 'Document symbol')
		end,
	})
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
