vim.pack.add({
	'https://github.com/stevearc/conform.nvim',
})

vim.defer_fn(function()
	local opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			json = { 'deno_fmt' },
			jsonc = { 'deno_fmt' },
			markdown = { 'deno_fmt' },
		},
		format_on_save = {
			timeout_ms = 700,
			lsp_format = 'fallback',
		},
		notify_on_error = true,
		-- log_level = vim.log.levels.DEBUG,
	}

	require('conform').setup(opts)

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	local usercmd = vim.api.nvim_create_user_command

	usercmd('Format', function(input)
		vim.notify('Formatting ... ', vim.log.levels.INFO, { title = 'Conform' })

		local function error(err)
			if err ~= nil then vim.notify(err, vim.log.levels.ERROR, { title = 'Conform' }) end
		end

		require('conform').format({ async = input.bang, timeout_ms = 700 }, error)
	end, { bang = true, range = true })
end, 80)
