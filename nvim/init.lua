-- Enable the experimental Lua module loader
vim.loader.enable()

-- General setup
require('options')
require('keybinds')
require('autocmds')
require('lsp')
require('statusline')

-- Colorscheme
local theme = vim.opt.background:get() == 'dark' and 'rosepine-moon' or 'rosepine-dawn'
vim.cmd.colorscheme(theme)

-- Interactive textual undotree
vim.cmd.packadd('nvim.undotree')

-- Enable the new experimental command-line features
require('vim._core.ui2').enable({})
