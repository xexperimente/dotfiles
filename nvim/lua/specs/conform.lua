local Plugin = { 'stevearc/conform.nvim' }

Plugin.dependencies = {
	'williamboman/mason.nvim',
}

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
	notify_on_error = false,
}

Plugin.keys = {
	{ 'gq', ':Format!<cr>', mode = { 'n', 'x' }, desc = 'Format' },
}

function Plugin.init()
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	local command = vim.api.nvim_create_user_command

	command('Format', function(input)
		vim.notify('Formatting ... ', vim.log.levels.INFO)

		require('conform').format(
			{ lsp_fallback = true, async = input.bang, timeout_ms = 700 },
			function(err)
				if err ~= nil then vim.notify(err, vim.log.levels.ERROR) end
			end
		)
	end, { bang = true, range = true })
end

return Plugin
