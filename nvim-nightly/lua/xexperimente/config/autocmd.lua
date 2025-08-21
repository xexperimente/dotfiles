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
	command = 'nnoremap <buffer> q <cmd>quit<cr>',
})

-- Clear search register on start
autocmd('UIEnter', {
	command = 'let @/=""',
})
