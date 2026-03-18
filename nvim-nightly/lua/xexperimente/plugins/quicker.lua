vim.schedule(function()
	vim.pack.add({ 'https://github.com/stevearc/quicker.nvim' })

	local qr = require('quicker')

	qr.setup({
		opts = {
			signcolumn = 'no',
		},
		borders = {
			vert = '|',
		},
		on_qf = function(bufnr)
			local winid = vim.fn.bufwinid(bufnr)
			vim.api.nvim_win_call(winid, function()
				vim.opt_local.listchars:append({ space = ' ' })
				vim.wo.statusline = ' %#StatusLineActive#%q%#StatusLine#%* %= %l/%L'

				vim.cmd('redrawstatus')
			end)
		end,
	})

	local bind = vim.keymap.set

	bind('n', '<leader>q', function() qr.toggle({ focus = true }) end, { desc = 'Toggle quickfix' })
	bind('n', '<leader>l', function() qr.toggle({ loclist = true, focus = true }) end, { desc = 'Toggle loclist' })
end)
