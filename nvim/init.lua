vim.loader.enable(true)

vim.g.mapleader = ' '
vim.g.winborder = 'single'
vim.o.winborder = vim.g.winborder


vim.opt.exrc = true
vim.opt.secure = true
require('xexperimente.core.lsp')
require('xexperimente.plugins')
