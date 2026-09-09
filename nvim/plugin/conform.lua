vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

	local conform = require('conform')

	conform.setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_format = 'fallback',
		},
		formatters_by_ft = {
			lua = { 'stylua' },
			json = { 'oxfmt' },
			jsonc = { 'oxfmt' },
			yaml = { 'oxfmt' },
			markdown = { 'oxfmt' },
			cpp = { 'clang-format' },
		},
	})

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = '*',
		callback = function(args) conform.format({ bufnr = args.buf }) end,
	})
end, 0)
