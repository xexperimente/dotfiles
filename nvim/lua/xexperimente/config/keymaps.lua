local bind = vim.keymap.set

-- Save with musle memory from windows
bind('n', '<C-s>', ':w!<cr>', { noremap = true, silent = true, desc = 'Save file' })
bind({ 'n', 'i' }, '<C-v>', '<C-R>+', { noremap = true, silent = true, desc = 'Paste' })

-- Cancel search highlight
bind('n', '<esc>', ':nohl<cr>', { noremap = true, silent = true, desc = 'Clear search' })

-- Cycle buffers
bind('n', ']b', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next buffer' })
bind('n', '[b', ':bprev<cr>', { noremap = true, silent = true, desc = 'Previous buffer' })

-- CLose buffer
bind('n', '<leader>bd', ':bd<cr>', { noremap = true, silent = true, desc = 'Close buffer' })

-- Select all text in current buffer
bind('n', '<leader>a', '<cmd>keepjumps normal! ggVG<cr>', { desc = 'Select all' })

-- Terminal
bind('t', '<esc>', [[<C-\><C-n>]], { desc = 'Escape terminal mode', noremap = true })
bind('t', '<esc><esc>', [[<C-\><C-n><C-w>q]], { desc = 'Close terminal', noremap = true })
