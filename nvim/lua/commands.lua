local usercmd = vim.api.nvim_create_user_command

usercmd('LspLog', function() vim.cmd.tabnew(vim.lsp.log.get_filename()) end, {})

usercmd('LspInfo', function() vim.cmd('checkhealth vim.lsp') end, {})

usercmd('ToggleInlayHints', function()
	vim.g.inlay_hints = not vim.g.inlay_hints
	vim.notify(string.format('%s inlay hints...', vim.g.inlay_hints and 'Enabling' or 'Disabling'), vim.log.levels.INFO)

	local mode = vim.api.nvim_get_mode().mode
	vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == 'n' or mode == 'v'))
end, { desc = 'Toggle inlay hints', nargs = 0 })

usercmd('Scratch', function()
	vim.cmd('bel 10new')
	local buf = vim.api.nvim_get_current_buf()
	for name, value in pairs({
		filetype = 'scratch',
		buftype = 'nofile',
		bufhidden = 'wipe',
		swapfile = false,
		modifiable = true,
	}) do
		vim.api.nvim_set_option_value(name, value, { buf = buf })
	end
end, { desc = 'Open a scratch buffer', nargs = 0 })
