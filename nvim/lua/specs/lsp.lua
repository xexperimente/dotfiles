-- LSP support
local Plugin = { 'neovim/nvim-lspconfig' }
local user = {}

Plugin.lazy = true

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

-- TODO: toggle inline hints

Plugin.dependencies = {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'williamboman/mason-lspconfig.nvim' },
	-- { 'folke/neodev.nvim', ft = 'lua', opts = { library = { plugins = false } } },
}

function Plugin.init()
	-- disable lsp semantic highlights
	vim.api.nvim_create_autocmd('ColorScheme', {
		desc = 'Clear LSP highlight groups',
		callback = function()
			local higroups = vim.fn.getcompletion('@lsp', 'highlight')
			for _, name in ipairs(higroups) do
				vim.api.nvim_set_hl(0, name, {})
			end
		end,
	})
end

function Plugin.config()
	-- require('neodev').setup()

	local lsp = require('lsp-zero')

	lsp.extend_lspconfig()
	lsp.on_attach(user.lsp_attach)

	user.diagnostics(lsp)
	user.ui()

	require('mason-lspconfig').setup({
		ensure_installed = {},
		handlers = {
			function(server_name) require('lspconfig')[server_name].setup({}) end,

			lua_ls = function()
				-- (Optional) Configure lua language server for neovim
				local lua_opts = lsp.nvim_lua_ls()
				require('lspconfig').lua_ls.setup(lua_opts)
			end,
		},
	})
end

function user.lsp_attach(_, bufnr)
	local telescope = require('telescope.builtin')
	local lsp = vim.lsp.buf
	local bind = vim.keymap.set
	local command = vim.api.nvim_buf_create_user_command

	command(0, 'LspFormat', function(input) vim.lsp.buf.format({ async = input.bang }) end, {})

	local opts = { silent = true, buffer = bufnr }

	bind({ 'n', 'x' }, 'gq', '<cmd>LspFormat!<cr>', opts)

	bind('n', 'K', lsp.hover, opts)
	bind('n', 'gd', telescope.lsp_definitions, opts) --lsp.definition, opts)
	bind('n', '<F12>', telescope.lsp_definitions, opts)
	bind('n', 'gD', lsp.declaration, opts)
	bind('n', 'gi', telescope.lsp_implementations, opts)
	bind('n', 'go', telescope.lsp_type_definitions, opts)
	bind('n', 'gr', telescope.lsp_references, opts) --lsp.references, opts)
	bind('n', 'gs', lsp.signature_help, opts)
	bind('i', '<C-S>', lsp.signature_help, opts)
	bind('n', 'crn', lsp.rename, opts)
	bind('n', 'crr', lsp.code_action, opts)
	bind('n', '<F2>', lsp.rename, opts)
	bind('n', '<F4>', lsp.code_action, opts)

	bind('n', '<C-W>d', vim.diagnostic.open_float, opts)
	bind('n', '[d', vim.diagnostic.goto_prev, opts)
	bind('n', ']d', vim.diagnostic.goto_next, opts)

	bind('n', '<leader>lp', telescope.diagnostics, opts)
	bind('n', '<leader>fd', telescope.lsp_document_symbols, opts)
	bind('n', '<leader>fq', telescope.lsp_workspace_symbols, opts)
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
		callback = function(e) vim.diagnostic.disable(e.buf) end,
	})

	autocmd('ModeChanged', {
		group = group,
		pattern = 'i:n',
		desc = 'Enable diagnostics when leaving insert mode',
		callback = function(e) vim.diagnostic.enable(e.buf) end,
	})
end

function user.ui()
	-- Border and color for LspInfo
	require('lspconfig.ui.windows').default_options = {
		border = 'single',
	}
end

return Plugin
