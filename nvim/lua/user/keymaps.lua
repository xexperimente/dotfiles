local bind = vim.keymap.set

-- Allow misspellings
local abbr = vim.cmd.cnoreabbrev
abbr('qw', 'wq')
abbr('Wq', 'wq')
abbr('WQ', 'wq')
abbr('Qa', 'qa')
abbr('Bd', 'bd')
abbr('bD', 'bd')

-- Save with musle memory from windows
bind('n', '<C-s>', ':w!<cr>', { noremap = true, silent = true, desc = 'Save file' })
bind('i', '<C-s>', '<esc>:w!<cr>i', { noremap = true, silent = true, desc = 'Save file' })

-- Paste
bind({ 'n', 'i' }, '<C-v>', '<C-R>+', { noremap = true, silent = true, desc = 'Paste' })
bind('c', '<C-v>', '<C-R>+', { noremap = true, desc = 'Paste(cmdline)' })

-- Visual Block Mode - since on windows cant do Ctrl-V
bind('n', '<leader>vb', '<C-v>', { noremap = true, desc = 'Start Visual Block Mode' })

-- Select all text in current buffer
bind('n', '<leader>va', '<cmd>keepjumps normal! ggVG<cr>', { desc = 'Select all' })

-- Terminal
bind('t', '<esc>', [[<C-\><C-n>]], { desc = 'Escape terminal mode', noremap = true })
bind('t', '<esc><esc>', [[<C-\><C-n><C-w>q]], { desc = 'Close terminal', noremap = true })

-- Cancel search highlight
bind('n', '<esc>', ':nohl<cr><esc>', { noremap = true, silent = true, desc = 'Clear search' })

-- Hlsearch next/prev in cmdline
bind('c', '<F3>', '<c-g>', { noremap = true, desc = 'Next search result' })
bind('c', '<S-F3>', '<c-t>', { noremap = true, desc = 'Previos search result' })
bind('n', 'S', '/', { desc = 'Search' })
bind('n', '<c-f>', '/<c-r><c-w>', { desc = 'Search' })
bind('n', '<c-b>', '<nop>')

-- Hlsearch next/prev
bind('n', '<F3>', 'n', { noremap = true, desc = 'Next search result' })
bind('n', '<S-F3>', 'N', { noremap = true, desc = 'Previous search result' })

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
