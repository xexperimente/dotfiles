local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function startuptime()
	if vim.g.strive_startup_time ~= nil then return end
	vim.g.strive_startup_time = 0
	local usage = vim.uv.getrusage()
	if usage then
		-- Calculate time in milliseconds (user + system time)
		local user_time = (usage.utime.sec * 1000) + (usage.utime.usec / 1000)
		local sys_time = (usage.stime.sec * 1000) + (usage.stime.usec / 1000)
		vim.g.nvim_startup_time = user_time + sys_time
	end
end

-- Measure startup time
autocmd('UIEnter', {
	group = augroup('xexperimente/dashboard', { clear = true }),
	once = true,
	callback = function() startuptime() end,
})

-- Do not add comment when adding new line
autocmd('BufEnter', {
	command = 'set fo-=c fo-=r fo-=o',
})

-- Reload message on file change
autocmd('FileChangedShellPost', {
	pattern = '*',
	command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- Allow closing the following buffer file types by pressing 'q' or 'esc'
autocmd('FileType', {
	group = augroup('xexperimente/close_keybinds', { clear = true }),
	pattern = { 'help', 'man', 'qf', 'nvim-pack' },
	desc = 'Close with <q> or <esc>',
	callback = function(ev)
		vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = true })
		vim.keymap.set('n', '<esc>', '<cmd>quit<cr>', { buffer = true })
		if ev.match == 'help' then vim.keymap.set('n', '<cr>', '<c-]>', { buffer = true }) end
	end,
})

-- Clear search register on start
autocmd('UIEnter', {
	command = 'let @/=""',
})

-- Disable indentscope in dashboard
autocmd('User', {
	pattern = { 'SnacksDashboardOpened', 'SnacksDashboardUpdatePost' },
	callback = function(data)
		vim.b[data.buf].miniindentscope_disable = true
		vim.b[data.buf].ministatusline_disable = true
	end,
})

--- Run command after updating plugin
autocmd('PackChanged', {
	group = augroup('xexperimente/pack-update-callback', { clear = true }),
	callback = function(event)
		local after = event.data.spec.data and event.data.spec.data.after
		if not after then return false end

		local pkg_name = event.data.spec.name
		local function wait()
			package.loaded[pkg_name] = nil
			local ok = pcall(require, pkg_name)

			if ok then
				if type(after) == 'string' then
					vim.cmd(after)
				elseif type(after) == 'function' then
					after()
				end
			else
				vim.defer_fn(wait, 50)
			end
		end

		wait()

		return false
	end,
})
