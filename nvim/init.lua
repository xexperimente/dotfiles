vim.loader.enable(true)

require("xexperimente.core.lazy")
require("xexperimente.core.lsp")
require("xexperimente.core.treesitter")

require("xexperimente.config.options")
require("xexperimente.config.keymaps")
require("xexperimente.config.autocmds")

vim.cmd('colorscheme rose-pine-dawn')