vim.o.clipboard = 'unnamedplus'

-- Silence `wl-paste`'s "Nothing is copied" stderr on an empty Wayland clipboard.
if vim.fn.has('linux') == 1 and vim.env.WAYLAND_DISPLAY then
	vim.g.clipboard = {
		name = 'wl-clipboard',
		copy = {
			['+'] = 'wl-copy --type text/plain',
			['*'] = 'wl-copy --primary --type text/plain',
		},
		paste = {
			['+'] = { 'sh', '-c', 'wl-paste --no-newline 2>/dev/null || true' },
			['*'] = { 'sh', '-c', 'wl-paste --primary --no-newline 2>/dev/null || true' },
		},
		cache_enabled = true,
	}
end

if vim.env.SSH_CONNECTION then
	local function vim_paste()
		local content = vim.fn.getreg('"') ---@as string
		return vim.split(content, '\n')
	end

	vim.g.clipboard = {
		name = 'OSC 52',
		copy = {
			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
		},
		paste = {
			['+'] = vim_paste,
			['*'] = vim_paste,
		},
	}
end
