local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking
autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
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

-- Allow closing the following buffer file types by pressing 'q'
autocmd('FileType', {
	pattern = { 'help', 'man', 'qf' },
	-- command = 'nnoremap <buffer> q <cmd>quit<cr>',
	callback = function()
		vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = true })
		vim.keymap.set('n', '<esc>', '<cmd>quit<cr>', { buffer = true })
	end,
})

-- Clear search register on start
autocmd('UIEnter', {
	command = 'let @/=""',
})

-- Disble indentscope in dashboard
autocmd('User', {
	pattern = 'SnacksDashboardOpened',
	callback = function(data)
		vim.b[data.buf].miniindentscope_disable = true
		vim.b[data.buf].ministatusline_disable = true
	end,
})
