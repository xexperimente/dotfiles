local Plugin = { 'carbon-steel/detour.nvim' }

Plugin.event = 'VeryLazy'

function Plugin.config()
	local bind = vim.keymap.set

	bind('n', '<leader>t', function()
		require('detour').Detour()

		vim.cmd.terminal()
		vim.cmd.startinsert()

		bind('n', '<esc>', [[<C-w><C-q>]], { desc = 'Close terminal', noremap = true, buffer = true })

		vim.bo.bufhidden = 'delete' -- Close terminal when window closes
		vim.wo.number = false
		vim.wo.signcolumn = 'no'
	end, { desc = 'Open terminal' })
end

return Plugin
