local path = vim.fn.stdpath('config')

local Plugin = {}

Plugin.name = 'buffer-nav'
Plugin.dir = vim.fs.joinpath(path, 'pack', Plugin.name)
Plugin.dependencies = { { 'MunifTanjim/nui.nvim', lazy = true } }
Plugin.lazy = true

Plugin.event = { 'VeryLazy' }

function Plugin.init()
	local bind = vim.keymap.set

	vim.g.buffer_nav_save = '<leader>w'

	bind('n', 'M', '<cmd>BufferNavMenu<cr>', { desc = 'Open buffer marks' })
	bind('n', '<leader>m', '<cmd>BufferNavMark<cr>', { desc = 'Mark buffer' })
	bind('n', '<leader>M', '<cmd>BufferNavMark!<cr>', { desc = 'Mark buffer and show marks' })
	bind('n', '<M-1>', '<cmd>BufferNav 1<cr>', { desc = 'Jump to marked buffer 1' })
	bind('n', '<M-2>', '<cmd>BufferNav 2<cr>', { desc = 'Jump to marked buffer 2' })
	bind('n', '<M-3>', '<cmd>BufferNav 3<cr>', { desc = 'Jump to marked buffer 3' })
	bind('n', '<M-4>', '<cmd>BufferNav 4<cr>', { desc = 'Jump to marked buffer 4' })
end

return Plugin
