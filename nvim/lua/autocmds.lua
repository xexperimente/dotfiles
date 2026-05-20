local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

-- Highlight when yanking
autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = augroup('xexperimente/yank-highlight', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

-- Do not add comment when adding new line
autocmd('BufEnter', {
	pattern = '',
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

-- Intercept checkhealth window creation to center it fully
autocmd('FileType', {
	pattern = 'checkhealth',
	callback = function()
		-- Get current screen dimensions
		local stats = vim.api.nvim_list_uis()[1]
		if not stats then return end

		-- Configure your desired window size
		local width = math.floor(stats.width * 0.8)
		local height = math.floor(stats.height * 0.8)

		-- Calculate centered offsets
		local row = math.floor((stats.height - height) / 2)
		local col = math.floor((stats.width - width) / 2)

		-- Apply configuration to the current checkhealth floating window
		vim.api.nvim_win_set_config(0, {
			relative = 'editor',
			width = width,
			height = height,
			border = vim.g.winborder,
			row = row,
			col = col,
		})
		--   vim.bo.modifiable = true
		--   vim.cmd([[%s/✅//ge]])
		-- -- vim.cmd[[silent! %s/\v( ?[^\x00-\x7F])//g]]
		--   vim.bo.modifiable = false
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

--- For rendering terminal escape codes
usercmd('Term', function(_)
	local buf = vim.api.nvim_get_current_buf()
	local b = vim.api.nvim_create_buf(false, true)
	local chan = vim.api.nvim_open_term(b, {})
	vim.api.nvim_chan_send(chan, table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), '\n'))
	vim.api.nvim_win_set_buf(0, b)
end, {})

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
