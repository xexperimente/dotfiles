local bind = vim.keymap.set

--- Open a non-interactive terminal and run a command. Keeps the current window focused.
---@param cmd string: The command to run
function run_non_interactive_cmd(cmd)
	return function()
		-- local win = vim.api.nvim_get_current_win()
		Snacks.terminal.open(cmd, { interactive = false, auto_close = true, win = { position = 'right' } })
		-- vim.api.nvim_set_current_win(win)
	end
end

bind('n', '<leader>rb', run_non_interactive_cmd('zig build'), { desc = 'run: zig build' })

bind('n', '<leader>rB', run_non_interactive_cmd('zig build run'), { desc = 'run: zig build run' })
