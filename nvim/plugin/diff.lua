vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/sindrets/diffview.nvim' })

	require('diffview').setup({
		default_args = {
			DiffviewFileHistory = { '%' },
		},
	})

	local bind = vim.keymap.set

	bind('n', '<leader>df', '<cmd>DiffviewFileHistory<cr>', { desc = 'Open file history' })
	bind('n', '<leader>dv', '<cmd>DiffviewOpen<cr>', { desc = 'Open diffview' })
	bind('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })

	-- 	vim.api.nvim_create_user_command("DiffviewToggle", function(e)
	--   local view = require("diffview.lib").get_current_view()
	--
	--   if view then
	--     vim.cmd("DiffviewClose")
	--   else
	--     vim.cmd("DiffviewOpen " .. e.args)
	--   end
	-- end, { nargs = "*" })
end, 0)
