local add_on_event = require('pack').add_on_event

add_on_event('BufWritePre', {
	{
		src = 'stevearc/conform.nvim',
		opts = {
			-- Leave me alone.
			notify_on_error = false,
			notify_no_formatters = false,
			formatters_by_ft = {
				cpp = { name = 'clangd', timeout_ms = 500, lsp_format = 'prefer' },
				lua = { 'stylua' },
				rust = { name = 'rust_analyzer', timeout_ms = 500, lsp_format = 'prefer' },
				sh = { 'shfmt' },
				yaml = { 'oxfmt' },
				-- For filetypes without a formatter:
				['_'] = { 'trim_whitespace', 'trim_newlines' },
			},
			format_on_save = function()
				-- Don't format when minifiles is open, since that triggers the "confirm without
				-- synchronization" message.
				if vim.g.minifiles_active then return nil end

				-- Skip formatting if triggered from my special save command.
				if vim.g.skip_formatting then
					vim.g.skip_formatting = false
					return nil
				end

				-- Stop if we disabled auto-formatting.
				if not vim.g.autoformat then return nil end

				return {}
			end,
			formatters = {},
		},
	},
})

-- Use conform for gq.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Start auto-formatting by default (and disable with my ToggleFormat command).
vim.g.autoformat = true
