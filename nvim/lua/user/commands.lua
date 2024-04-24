-- Do not add comment when adding new line
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '',
	command = 'set fo-=c fo-=r fo-=o',
})

-- Reload message on file change
vim.api.nvim_create_autocmd('FileChangedShellPost', {
	pattern = '*',
	command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

local user_au_group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

-- Allow closing the following buffer file types by pressing 'q'
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help', 'man', 'qf' },
	group = user_au_group,
	command = 'nnoremap <buffer> q <cmd>quit<cr>',
})
