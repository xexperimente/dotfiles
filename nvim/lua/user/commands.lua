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
