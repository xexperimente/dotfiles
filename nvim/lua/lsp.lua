local diagnostic_icons = require('icons').diagnostics

local M = {}

-- Disable inlay hints initially (and enable if needed with my ToggleInlayHints command).
vim.g.inlay_hints = false

local servers = { 'emmylua_ls', 'clangd' }

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	local bind = vim.keymap.set
	local vd = vim.diagnostic

	bind('n', '[e', function() vd.jump({ count = -1, severity = vd.severity.ERROR }) end, { desc = 'Previous error' })
	bind('n', ']e', function() vd.jump({ count = 1, severity = vd.severity.ERROR }) end, { desc = 'Next error' })
	bind('n', '<leader>cd', vd.open_float, { desc = 'Open floating diagnostics' })

	if client:supports_method('textDocument/codeLens') then
		vim.lsp.codelens.enable(true)

		vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
			buffer = bufnr,
			callback = function() vim.lsp.codelens.enable(true, { bufnr = bufnr }) end,
		})

		bind({ 'n', 'x' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
		bind('n', '<leader>cC', function() vim.lsp.codelens.enable(true) end, { desc = 'Refresh Codelens' })
	end

	if client:supports_method('textDocument/codeAction') then
		bind({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
		bind({ 'n', 'x' }, '<f4>', vim.lsp.buf.code_action, { desc = 'Code Action' })
	end

	if client:supports_method('textDocument/rename') then
		bind('n', '<f2>', vim.lsp.buf.rename, { desc = 'Rename' })
		bind('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
	end
	if client:supports_method('textDocument/codeAction') then require('lightbulb').attach_lightbulb(bufnr, client) end
end

--- @param severity vim.diagnostic.Severity
--- @return string
local function get_severity_string(severity)
	local map = {
		[vim.diagnostic.severity.ERROR] = 'Error',
		[vim.diagnostic.severity.WARN] = 'Warn',
		[vim.diagnostic.severity.HINT] = 'Hint',
		[vim.diagnostic.severity.INFO] = 'Info',
	}

	return map[severity]
end

-- Diagnostic configuration.
vim.diagnostic.config({
	status = {
		format = function(counts)
			local items = {}
			for severity, count in pairs(counts) do
				local hl = 'DiagnosticSign' .. get_severity_string(severity) --name:sub(1, 1) .. name:sub(2):lower()
				table.insert(items, ('%%#%s#%s %d'):format(hl, diagnostic_icons[severity], count))
			end
			return table.concat(items, ' ')
		end,
	},
	virtual_text = {
		prefix = '',
		spacing = 2,
		format = function(diagnostic)
			-- Use shorter, nicer names for some sources:
			local special_sources = {
				['Lua Diagnostics.'] = 'lua',
				['Lua Syntax Check.'] = 'lua',
			}

			local message = diagnostic_icons[diagnostic.severity]
			if diagnostic.source then
				message = string.format('%s %s', message, special_sources[diagnostic.source] or diagnostic.source)
			end
			if diagnostic.code then message = string.format('%s[%s]', message, diagnostic.code) end

			return message .. ' '
		end,
	},
	float = {
		source = 'if_many',
		-- Show severity icons as prefixes.
		prefix = function(diagnostic)
			local prefix = string.format(' %s ', diagnostic_icons[diagnostic.severity])
			return prefix, get_severity_string(diagnostic.severity)
		end,
	},
	signs = { text = diagnostic_icons },
})

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'Configure LSP keymaps',
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then return end

		on_attach(client, args.buf)
	end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
	once = true,
	callback = function()
		-- Extend neovim's client capabilities with the completion ones.
		vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })

		vim.lsp.enable(servers)
	end,
})

return M
