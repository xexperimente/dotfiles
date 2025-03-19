local autocmd = vim.api.nvim_create_autocmd

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

local augroup = vim.api.nvim_create_augroup('UserCmds', { clear = true })

-- Allow closing the following buffer file types by pressing 'q'
autocmd('FileType', {
	pattern = { 'help', 'man', 'qf' },
	group = augroup,
	command = 'nnoremap <buffer> q <cmd>quit<cr>',
})

-- Disable MiniIndentScope and MiniCursorword in symbols.nvim window
autocmd('FileType', {
	pattern = 'SymbolsSidebar',
	group = augroup,
	callback = function(ev)
		vim.b.miniindentscope_config = { draw = { predicate = function() return false end } }
		vim.b.minicursorword_disable = true

		vim.keymap.set('n', '<left>', function() require('symbols').api.action('toggle-fold') end, { buffer = ev.buf })
		vim.keymap.set('n', '<right>', function() require('symbols').api.action('toggle-fold') end, { buffer = ev.buf })
	end,
})

-- Disable MiniCursorword in for specific keywords
autocmd('CursorMoved', {
	group = augroup,
	callback = function()
		if vim.b.minicursorword_disable then return end

		local curword = vim.fn.expand('<cword>')
		local filetype = vim.bo.filetype

		-- Add any disabling global or filetype-specific logic here
		local blocklist = {}

		if filetype == 'lua' then
			blocklist = { 'local', 'require', 'function' }
			vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
		end
	end,
})
