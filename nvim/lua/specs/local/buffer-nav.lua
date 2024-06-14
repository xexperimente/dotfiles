local path = vim.fn.stdpath('config')

local Plugin = {}

Plugin.name = 'buffer-nav'
Plugin.dir = vim.fs.joinpath(path, 'pack', Plugin.name)
Plugin.dependencies = { { 'MunifTanjim/nui.nvim', lazy = true } }
Plugin.lazy = true

Plugin.keys = {
	{ 'M' },
	{ '<leader>m' },
	{ '<leader>M' },
	{ '<M-1>' },
	{ '<M-2>' },
	{ '<M-3>' },
	{ '<M-4>' },
}

function Plugin.init() vim.g.buffer_nav_save = '<leader>w' end

function Plugin.config()
	vim.keymap.set('n', 'M', '<cmd>BufferNavMenu<cr>', { desc = 'Open buffer marks' })
	vim.keymap.set('n', '<leader>m', '<cmd>BufferNavMark<cr>', { desc = 'Mark buffer' })
	vim.keymap.set('n', '<leader>M', '<cmd>BufferNavMark!<cr>', { desc = 'Mark buffer' })
	vim.keymap.set('n', '<M-1>', '<cmd>BufferNav 1<cr>', { desc = 'Jump to marked buffer 1' })
	vim.keymap.set('n', '<M-2>', '<cmd>BufferNav 2<cr>', { desc = 'Jump to marked buffer 2' })
	vim.keymap.set('n', '<M-3>', '<cmd>BufferNav 3<cr>', { desc = 'Jump to marked buffer 3' })
	vim.keymap.set('n', '<M-4>', '<cmd>BufferNav 4<cr>', { desc = 'Jump to marked buffer 4' })
end

return Plugin
