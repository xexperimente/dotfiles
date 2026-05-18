-- Enable the experimental Lua module loader
vim.loader.enable(true)

-- General setup
require('options')
require('keybinds')
require('autocmds')
require('lsp')
require('statusline')

-- Interactive textual undotree:
vim.cmd.packadd('nvim.undotree')

-- Colorscheme
local theme = vim.opt.background:get() == 'dark' and 'rosepine-moon' or 'rosepine-dawn'
vim.cmd.colorscheme(theme)

-- Enable the new experimental command-line features
require('vim._core.ui2').enable({})
