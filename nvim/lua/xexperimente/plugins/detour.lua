local Plugin = { 'carbon-steel/detour.nvim' }

Plugin.lazy = true

Plugin.cmd = { 'Detour', 'DetourCurrentWindow' }

Plugin.keys = { '<leader>t' }

function Plugin.config()
	local bind = vim.keymap.set

	bind('n', '<c-w>n', '<cmd>Detour<cr>', { noremap = true, desc = 'Open Detour window' })

	bind('n', '<c-w>.', '<cmd>DetourCurrentWindow<cr>', { desc = 'Open Detour window over current' })

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
