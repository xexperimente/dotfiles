local bind = vim.keymap.set
local abbr = vim.cmd.cnoreabbrev

-- Allow misspellings
abbr('qw', 'wq')
abbr('Wq', 'wq')
abbr('WQ', 'wq')
abbr('Qa', 'qa')
abbr('Bd', 'bd')
abbr('bD', 'bd')

local default_opts = { noremap = true, silent = true }

bind('n', '<leader>pu', '<cmd>Lazy update<cr>', default_opts)
bind('n', '<leader>pi', '<cmd>Lazy install<cr>', default_opts)
bind('n', '<leader>pp', '<cmd>Lazy profile<cr>', default_opts)
bind('n', '<leader>pl', '<cmd>Lazy<cr>', default_opts)

-- Paste
bind('i', '<C-v>', '<C-R>+', { noremap = true, silent = true, desc = 'Paste' })
bind('c', '<C-v>', '<C-R>+', { noremap = true, desc = 'Paste(cmdline)' })

-- Visual Block Mode - since on windows cant do Ctrl-V
bind('n', '<leader>vb', '<C-v>', { noremap = true, desc = 'Start Visual Block Mode' })

-- Select all text in current buffer
bind('n', '<leader>va', '<cmd>keepjumps normal! ggVG<cr>', { desc = 'Select all' })
bind('n', '<C-a>', '<cmd>keepjumps normal! ggVG<cr>', { desc = 'Select all' })

-- Terminal
bind('t', '<esc>', [[<C-\><C-n>]], { desc = 'Escape terminal mode', noremap = true })
bind('t', '<esc><esc>', [[<C-\><C-n><C-w>q]], { desc = 'Close terminal', noremap = true })

-- Cancel search highlight
bind('n', '<esc>', ':nohl<cr>:redraws!<cr><esc>', { noremap = true, silent = true, desc = 'Hide search' })
bind('n', '<leader><space>', ':let @/=""<cr>:redraws!<cr>', { noremap = true, silent = true, desc = 'Clear search' })

-- Hlsearch next/prev
bind('c', '<F3>', '<c-g>', { noremap = true, desc = 'Next search result' })
bind('n', '<F3>', 'n', { noremap = true, desc = 'Next search result' })
bind('c', '<S-F3>', '<c-t>', { noremap = true, desc = 'Previos search result' })
bind('n', '<S-F3>', 'N', { noremap = true, desc = 'Previous search result' })
bind('n', '<c-f>', '/<c-r><c-w>', { desc = 'Search' })

-- Redo
bind('n', 'U', ':redo<cr>', { desc = 'Redo' })

-- Line move using 'Alt'
bind('n', '<A-j>', ':m .+1<CR>==')
bind('n', '<A-k>', ':m .-2<CR>==')
bind('v', '<A-j>', ":m '>+1<CR>gv=gv")
bind('v', '<A-k>', ":m '<-2<CR>gv=gv")

bind('n', '<A-Down>', ':m .+1<CR>==')
bind('n', '<A-Up>', ':m .-2<CR>==')
bind('v', '<A-Down>', ":m '>+1<CR>gv=gv")
bind('v', '<A-Up>', ":m '<-2<CR>gv=gv")

-- Keep selection after indent
bind('v', '>', '>gv', { noremap = true, desc = 'Increase selection indentation' })
bind('v', '<', '<gv', { noremap = true, desc = 'Decrease selection indentation' })

-- Selection like in Windows
bind('n', '<S-Up>', 'V')
bind('n', '<S-Down>', 'V')
bind('v', '<S-Up>', 'k')
bind('v', '<S-Down>', 'j')
