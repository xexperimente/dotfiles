local bind = vim.keymap.set

local default_opts = { noremap = true, silent = true }

bind("n", "<leader>pu", "<cmd>Lazy update<cr>", default_opts)
bind("n", "<leader>pi", "<cmd>Lazy install<cr>", default_opts)
bind("n", "<leader>pp", "<cmd>Lazy profile<cr>", default_opts)
