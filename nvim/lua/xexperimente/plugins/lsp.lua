local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.lazy = false

Plugin.dependencies = {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
	{ 'folke/neodev.nvim', opts = {} },
}

function Plugin.init()
	vim.g.lsp_zero_extend_cmp = 0
	vim.g.lsp_zero_extend_lspconfig = 0
end

function Plugin.config()
	require('neodev').setup()

	local lz = require('lsp-zero')

	user.lspconfig(lz)
	user.diagnostics(lz)

	require('mason-lspconfig').setup()
end

function user.lspconfig(lsp)
	lsp.extend_lspconfig()

	lsp.on_attach(user.lsp_attach)

	lsp.set_server_config({
		single_file_support = false,
		-- on_init = function(client) client.server_capabilities.semanticTokensProvider = nil end,
		-- root_dir = function() return vim.fn.getcwd() end,
	})

	lsp.store_config('powershell_es', user.powershell_opts())

	require('mason-lspconfig').setup({
		ensure_installed = { 'lua_ls', 'powershell_es' },
		handlers = {
			lsp.default_setup,
			lua_ls = function() require('lspconfig').lua_ls.setup(user.lua_opts()) end,
		},
	})
end

function user.lua_opts()
	return {
		settings = {
			Lua = {
				hint = {
					enable = true,
					arrayIndex = 'Disable',
					semicolon = 'Disable',
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	}
end

function user.powershell_opts()
	local mason_registry = require('mason-registry')

	return {
		bundle_path = mason_registry.get_package('powershell-editor-services'):get_install_path(),
		init_options = {
			enableProfileLoading = false,
		},
	}
end

function user.lsp_attach(client, bufnr)
	local telescope = require('telescope.builtin')
	local lsp = vim.lsp.buf
	local bind = vim.keymap.set

	-- local opts = { silent = true, buffer = bufnr }
	local function opts(desc) return { silent = true, buffer = bufnr, desc = desc } end

	bind('n', '<leader>lk', lsp.hover, opts('Hover'))
	bind('n', '<leader>lK', lsp.signature_help, opts('Signature help'))
	bind('n', '<leader>ld', telescope.lsp_definitions, opts('Go to Definitions')) --lsp.definition
	bind('n', '<leader>lD', lsp.declaration, opts('Go to declaration'))
	bind('n', '<leader>li', telescope.lsp_implementations, opts('Go to impl')) --lsp.implementations
	bind('n', '<leader>lt', lsp.type_definition, opts('Type definition'))
	bind('n', '<F2>', lsp.rename, opts('Rename'))
	bind('n', '<F4>', lsp.code_action, opts('Code actions'))
	bind('n', '<leader>la', lsp.code_action, opts('Code actions'))
	bind('n', '<F12>', telescope.lsp_definitions, opts('Go to Definitions'))
	bind('n', '<leader>lr', telescope.lsp_references, opts('Show References'))
	bind('n', '<leader>lp', telescope.diagnostics, opts('Show diagnostics'))
	bind('n', '<leader>lo', telescope.lsp_document_symbols, opts('Document symbols'))
	bind('n', '<leader>lg', telescope.lsp_dynamic_workspace_symbols, opts('Workspace symbols'))

	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	if inlay_hint then
		if client.supports_method('textDocument/inlayHint') then
			inlay_hint(bufnr, false)

			bind('n', '<leader>lh', function() inlay_hint(0, nil) end, { desc = 'Toggle inlay hints' })
		end
	end
end

function user.diagnostics(lsp)
	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	lsp.set_sign_icons({
		error = '',
		warn = '',
		hint = '',
		info = '',
	})

	vim.diagnostic.config({
		virtual_text = true,
	})

	local group = augroup('diagnostic_cmds', { clear = true })

	autocmd('ModeChanged', {
		group = group,
		pattern = { 'n:i', 'v:s' },
		desc = 'Disable diagnostics while typing',
		callback = function() vim.diagnostic.disable(0) end,
	})

	autocmd('ModeChanged', {
		group = group,
		pattern = 'i:n',
		desc = 'Enable diagnostics when leaving insert mode',
		callback = function() vim.diagnostic.enable(0) end,
	})
end

return Plugin
