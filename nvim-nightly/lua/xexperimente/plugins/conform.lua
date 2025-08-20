vim.pack.add({
	'https://github.com/stevearc/conform.nvim',
})

local opts = {
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

require('conform').setup(opts)

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local usercmd = vim.api.nvim_create_user_command

usercmd('Format', function(input)
	vim.notify('Formatting ... ', vim.log.levels.INFO, { title = 'Conform' })

	local function error(err)
		if err ~= nil then vim.notify(err, vim.log.levels.ERROR, { title = 'Conform' }) end
	end

	require('conform').format({ lsp_fallback = true, async = input.bang, timeout_ms = 700 }, error)
end, { bang = true, range = true })
