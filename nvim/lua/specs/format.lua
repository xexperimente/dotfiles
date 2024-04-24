local Plugin = { 'stevearc/conform.nvim' }

Plugin.dependencies = { 'williamboman/mason.nvim' }

Plugin.lazy = true

Plugin.event = { 'BufReadPre', 'BufNewFile' } --'BufWritePre'

Plugin.cmd = 'ConformInfo'

Plugin.opts = {
	-- What formatters to use
	formatters_by_ft = {
		lua = { 'stylua' },
	},
	-- Setup format on save autocmd
	format_on_save = {
		timeout_ms = 700,
		lsp_fallback = true,
	},
	-- customize formatters
	formatters = {
		stylua = {
			command = 'stylua.cmd',
		},
	},
	notify_on_error = false,
}

function Plugin.init()
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
		vim.notify('Runing format', vim.log.levels.INFO)

		require('conform').format(
			{ lsp_fallback = true, async = false, timeout_ms = 500 },
			function(err)
				if err == nil then
					vim.notify('Format ok', vim.log.levels.INFO)
				else
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		)
	end, { desc = 'Format' })
end

return Plugin
