local M = {}

-- Window utils
M.is_floating = function()
	local parent = vim.api.nvim_get_current_win()
	return vim.api.nvim_win_get_config(parent).relative ~= ''
end

M.is_active = function() return vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin) end

M.is_file_window = function() return vim.bo.buftype == '' end

M.close_current_window = function()
	local w = vim.api.nvim_get_current_win()
	vim.notify(vim.inspect(w))
	vim.api.nvim_win_close(w, false)
end

-- Buffer utils
M.get_current_buffer_filename = function()
	local bufnr = vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(bufnr)
end

return M
