local bind = vim.keymap.set

-- Save with musle memory from windows
bind('n', '<C-s>', ':w!<cr>', { noremap = true, silent = true, desc = 'Save file' })
bind({ 'n', 'i' }, '<C-v>', '<C-R>+', { noremap = true, silent = true, desc = 'Paste' })

-- Visual Block Mode - since on windows cant do Ctrl-V
bind('n', '<leader>vb', '<C-v>', { noremap = true, desc = 'Start Visual Block Mode' })

-- Cancel search highlight
bind('n', '<esc>', ':nohl<cr><esc>', { noremap = true, silent = true, desc = 'Clear search' })

-- Hlsearch next/prev in cmdline
bind('c', '<F3>', '<c-g>', { noremap = true, desc = 'Next search result' })
bind('c', '<S-F3>', '<c-t>', { noremap = true, desc = 'Previos search result' })

-- Hlsearch next/prev
bind('n', '<F3>', 'n', { noremap = true, desc = 'Next search result' })
bind('n', '<S-F3>', 'N', { noremap = true, desc = 'Previous search result' })

-- Cycle buffers
bind('n', ']b', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next buffer' })
bind('n', '[b', ':bprev<cr>', { noremap = true, silent = true, desc = 'Previous buffer' })

-- Close buffer
bind('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = 'Close buffer' })

-- Select all text in current buffer
bind('n', '<leader>a', '<cmd>keepjumps normal! ggVG<cr>', { desc = 'Select all' })

-- Terminal
bind('t', '<esc>', [[<C-\><C-n>]], { desc = 'Escape terminal mode', noremap = true })
bind('t', '<esc><esc>', [[<C-\><C-n><C-w>q]], { desc = 'Close terminal', noremap = true })

-- Window Movement
bind('n', '<C-h>', '<C-w>h')
bind('n', '<C-j>', '<C-w>j')
bind('n', '<C-k>', '<C-w>k')
bind('n', '<C-l>', '<C-w>l')

bind('t', '<C-h>', '<cmd>wincmd h<CR>')
bind('t', '<C-j>', '<cmd>wincmd j<CR>')
bind('t', '<C-k>', '<cmd>wincmd k<CR>')
bind('t', '<C-l>', '<cmd>wincmd l<CR>')

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
