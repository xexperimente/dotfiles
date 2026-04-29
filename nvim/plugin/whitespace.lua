vim.schedule(function()
	vim.pack.add({ 'https://github.com/mcauley-penney/visual-whitespace.nvim' })

	local opts = {
		enabled = true,
		match_types = {
			space = true,
			tab = true,
			nbsp = true,
			lead = false,
			trail = false,
		},
		list_chars = {
			space = vim.opt.listchars:get().space,
			tab = vim.opt.listchars:get().tab,
			nbsp = vim.opt.listchars:get().nbsp,
		},
		fileformat_chars = {
			unix = '',
			mac = '←',
			dos = '',
		},
	}

	require('visual-whitespace').setup(opts)
	local bind = vim.keymap.set

	bind({ 'n', 'v' }, '<leader>us', require('visual-whitespace').toggle, { desc = 'Toggle visual whitespace' })
	bind('n', '<leader>uS', function()
		vim.notify('Whitespace is ' .. (vim.opt.list:get() and 'off' or 'on'))
		vim.opt.list = not vim.opt.list:get()
	end, { desc = 'Toggle whitespace' })
end)
