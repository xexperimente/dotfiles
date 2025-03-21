local M = {}
local s = {}

M.window = nil
s.mounted = false
s.augroup = 'UserBuffernavCmds'

function M.after_mount(event)
	if M.window == nil then return end

	local window = M.window

	local close = function() window:hide() end

	local accept = function()
		local index = vim.fn.line('.')
		close()
		M.go_to_file(index)
	end

	local bind = vim.keymap.set
	local opts = { buffer = event.buf }

	bind('n', '<esc>', close, opts)
	bind('n', 'q', close, opts)
	bind('n', '<C-c>', close, opts)

	if vim.g.buffer_nav_save then bind('n', vim.g.buffer_nav_save, '<cmd>BufferNavSave<cr>', opts) end

	bind('n', '<cr>', accept, opts)
	bind('n', '<M-b>', accept, opts)

	vim.api.nvim_create_autocmd('BufLeave', {
		group = s.augroup,
		buffer = event.buf,
		once = true,
		callback = close,
	})
end

function M.show_menu()
	if M.window == nil then
		M.window = s.create_window()
	elseif M.window.bufnr == nil and s.filepath then
		M.load_content(s.filepath)
	end

	if s.mounted then
		M.window:show()
	else
		M.window:mount()
		s.mounted = true
	end
end

function M.add_file(opts)
	opts = opts or {}
	local name = vim.fn.bufname('%')
	local should_mount = M.window == nil
	local show_buffers = opts.show_buffers == true

	if M.window == nil then
		M.window = s.create_window()
	elseif M.window.bufnr == nil then
		if s.filepath then M.load_content(s.filepath) end
	end

	local start_row = vim.api.nvim_buf_line_count(M.window.bufnr)
	local end_row = start_row

	if start_row == 1 then
		local line = vim.api.nvim_buf_get_lines(M.window.bufnr, 0, 1, true)
		if vim.trim(line[1]) == '' then start_row = 0 end
	end

	vim.api.nvim_buf_set_lines(
		M.window.bufnr,
		start_row,
		end_row,
		false,
		{ vim.fn.fnamemodify(name, ':.') }
	)

	if show_buffers == false then return end

	if should_mount then
		M.window:mount()
		s.mounted = true
	else
		M.window:show()
	end
end

function M.go_to_file(index)
	if M.window == nil then return end

	local count = vim.api.nvim_buf_line_count(M.window.bufnr)

	if index > count then return end

	local path = vim.api.nvim_buf_get_lines(M.window.bufnr, index - 1, index, false)[1]

	if path == nil then return end

	if vim.fn.bufloaded(path) == 1 then
		vim.cmd.buffer(path)
		return
	end

	if vim.uv.fs_stat(path) then vim.cmd.edit(path) end
end

function M.load_content(path)
	if M.window then
		M.window:unmount()
		s.filepath = nil
	end

	local window = s.create_window()
	vim.api.nvim_buf_call(window.bufnr, function()
		vim.cmd.read(path)
		s.filepath = path
		vim.api.nvim_buf_set_lines(window.bufnr, 0, 1, false, {})
	end)

	M.window = window
end

function s.create_window()
	local Popup = require('nui.popup')
	local position = {
		row = '45%',
		col = '50%',
	}
	local size = {
		width = '50%',
		height = '30%',
	}

	local window = Popup({
		position = position,
		size = size,
		relative = 'editor',
		enter = true,
		focusable = true,
		border = {
			style = require('user.env').border,
			text = {
				top = {
					{ 'Buffers', 'MiniPickBorderText' },
				},
			},
		},
		buf_options = {
			filetype = 'BufferNav',
		},
		win_options = {
			number = true,
			cursorline = vim.o.cursorline,
		},
	})

	s.mounted = false

	return window
end

function M.save_content(path)
	if vim.bo.filetype ~= 'BufferNav' then return end

	if path == '' then path = s.filepath end

	if path == nil then
		vim.notify('Must provide a filepath', vim.log.levels.WARN)
		return
	end

	s.filepath = path
	vim.cmd.write({ args = { path }, bang = true })
end

return M
