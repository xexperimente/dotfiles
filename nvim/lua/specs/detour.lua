local Plugin = { 'carbon-steel/detour.nvim' }

Plugin.lazy = true
Plugin.cmd = { 'Detour', 'DetourCurrentWindow' }

Plugin.keys = {
	{ '<leader>t', desc = 'Open terminal' },
	{ '<C-W>n', desc = 'Open Detour window' },
	{ '<C-W>.', desc = 'Open Detour window over current' },
}

function Plugin.config()
	local bind = vim.keymap.set

	bind('n', '<c-w>n', function()
		local current_bufnr = vim.api.nvim_get_current_buf()
		local current_winid = vim.api.nvim_get_current_win()

		require('detour').Detour()

		vim.bo.bufhidden = 'delete' -- close the terminal when window closes

		local augroup = vim.api.nvim_create_augroup('UserDetourCmds', { clear = true })

		vim.api.nvim_create_autocmd({ 'WinLeave' }, {
			buffer = current_bufnr,
			callback = function()
				vim.api.nvim_win_close(current_winid, true)
				-- this autocmd only needs to return once so make sure you return true so it deletes itself after running.
				return true
			end,
			group = augroup,
			-- this nested attribute is actually needed at the moment or breaks the plugin's assumptions.
			-- I need to update the plugin so it doesn't depend on users remembering to setting the nested attribute.
			nested = true,
		})
	end, { noremap = true, desc = 'Open Detour' })

	bind('n', '<c-w>.', '<cmd>DetourCurrentWindow<cr>', { desc = 'Open current detour' })

	bind('n', '<leader>t', function()
		require('detour').Detour()

		vim.cmd.terminal()
		vim.cmd.startinsert()

		vim.wo.statusline = '%#STTUSLINE_TERMINAL_MODE# TERMINAL %#Normal# '

		-- bind('n', '<esc>', [[<C-w><C-q>]], { desc = 'Close terminal', noremap = true, buffer = true })

		vim.bo.bufhidden = 'delete' -- Close terminal when window closes
		vim.wo.number = false
		vim.wo.signcolumn = 'no'
		vim.api.nvim_create_autocmd({ 'TermClose' }, {
			buffer = vim.api.nvim_get_current_buf(),
			callback = function()
				-- This automated keypress skips for you the "[Process exited 0]" message
				-- that the embedded terminal shows.
				vim.api.nvim_feedkeys('i', 'n', false)
			end,
		})
	end, { desc = 'Open terminal' })
end

return Plugin
