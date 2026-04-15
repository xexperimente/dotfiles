vim.loader.enable(true)

vim.g.mapleader = ' '
vim.g.winborder = 'single'

require('xexperimente.core.options')
require('xexperimente.core.keybinds')
require('xexperimente.core.lsp')
require('xexperimente.core.autocmd')

require('xexperimente.plugins')
