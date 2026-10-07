local diagnostic_icons = require('icons').diagnostics

local M = {}

-- Disable inlay hints initially (and enable if needed with my ToggleInlayHints command).
vim.g.inlay_hints = false

local servers = { 'emmylua_ls', 'clangd', 'nushell' }

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	local bind = vim.keymap.set
	local diag = vim.diagnostic

	bind('n', '[e', function() diag.jump({ count = -1, severity = diag.severity.ERROR }) end, { desc = 'Previous error' })
	bind('n', ']e', function() diag.jump({ count = 1, severity = diag.severity.ERROR }) end, { desc = 'Next error' })

	-- Enable codelens
	if client:supports_method('textDocument/codeLens') then
		local codelens = vim.lsp.codelens

		codelens.enable(true)

		local function toggle_codelens(buf) codelens.enable(not codelens.is_enabled(), buf and { bufnr = buf } or {}) end

		vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
			buffer = bufnr,
			callback = function() toggle_codelens(bufnr) end,
		})

		bind({ 'n', 'x' }, '<leader>cl', toggle_codelens, { desc = 'Toggle Codelens' })
	end

	-- Enable code actions
	if client:supports_method('textDocument/codeAction') then
		require('lightbulb').attach_lightbulb(bufnr, client) -- Show indicator on lines with code action.

		bind({ 'n', 'x' }, '<f4>', vim.lsp.buf.code_action, { desc = 'Code Action' })
	end

	if client:supports_method('textDocument/documentColor') then
		bind(
			{ 'n', 'x' },
			'grc',
			vim.lsp.document_color.color_presentation,
			{ desc = 'vim.lsp.document_color.color_presentation()' }
		)
	end

	if client:supports_method('textDocument/references') then
		bind('n', 'grr', '<cmd>lua Snacks.picker.lsp_references()<cr>', { desc = 'vim.lsp.buf.references()' })
	end

	if client:supports_method('textDocument/typeDefinition') then
		bind('n', 'grt', '<cmd>lua Snacks.picker.lsp_type_definitions<cr>', { desc = 'Go to type definition' })
	end

	if client:supports_method('textDocument/documentSymbol') then
		bind('n', 'gO', '<cmd>lua Snacks.picker.lsp_symbols<cr>', { desc = 'Document symbols' })
	end

	if client:supports_method('textDocument/definition') then
		bind('n', 'gd', Snacks.picker.lsp_definitions, { desc = 'Go to definition' })
		bind('n', 'gD', Snacks.picker.lsp_declarations, { desc = 'Go to declaration' })
	end

	-- Enable symbol rename
	if client:supports_method('textDocument/rename') then
		bind('n', '<f2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
	end

	-- Show diagnostic float window
	if client:supports_method('textDocument/diagnostic') then
		bind('n', '<leader>cd', diag.open_float, { desc = 'Open diagnostics window' })
	end
end

--- @param severity vim.diagnostic.Severity
--- @return string
local function get_severity_name(severity)
	local map = {
		[vim.diagnostic.severity.ERROR] = 'Error',
		[vim.diagnostic.severity.WARN] = 'Warn',
		[vim.diagnostic.severity.HINT] = 'Hint',
		[vim.diagnostic.severity.INFO] = 'Info',
	}

	return map[severity]
end

local function fix_codelens_align()
	-- Provider is private in 0.12, so retrieve it from codelens.get().
	local provider
	for i = 1, 20 do
		local name, value = debug.getupvalue(vim.lsp.codelens.get, i)

		if not name then break end

		if name == 'Provider' then
			provider = value
			break
		end
	end

	assert(provider, 'Could not find vim.lsp.codelens Provider')

	if not provider._indent_alignment_patched then
		local original_on_win = provider.on_win

		provider.on_win = function(self, toprow, botrow)
			local original_range_lsp = vim.range.lsp

			-- codelens.on_win() uses range.start_col as the amount of
			-- padding before the virtual-line text. Replace that value
			-- with the indentation width of the actual source line.
			vim.range.lsp = function(bufnr, lsp_range, encoding)
				local range = original_range_lsp(bufnr, lsp_range, encoding)

				local row = lsp_range.start.line
				local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ''

				local indent = line:match('^%s*') or ''

				range.start_col = vim.fn.strdisplaywidth(indent)

				return range
			end

			-- Make sure vim.range.lsp is restored even if rendering fails.
			local ok, err = xpcall(function() original_on_win(self, toprow, botrow) end, debug.traceback)

			vim.range.lsp = original_range_lsp

			if not ok then error(err) end
		end

		provider._indent_alignment_patched = true
	end
end

-- Diagnostic configuration.
vim.diagnostic.config({
	status = {
		format = function(counts)
			local items = {}
			for severity, count in pairs(counts) do
				local hl = 'DiagnosticSign' .. get_severity_name(severity)
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
			return prefix, get_severity_name(diagnostic.severity)
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
		vim.lsp.config('*', { capabilities = vim.lsp.protocol.make_client_capabilities() }) --require('blink.cmp').get_lsp_capabilities(nil, true) })

		vim.lsp.enable(servers)

		-- Align CodeLens text to line indentation.
		fix_codelens_align()
	end,
})

-- Disable LSP in diff mode
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('xexperimente/lsp', { clear = true }),
	callback = function() vim.diagnostic.enable(not vim.opt.diff:get()) end,
})

return M
