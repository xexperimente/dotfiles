local abbr = vim.cmd.cnoreabbrev

-- Allow misspellings
abbr('qw', 'wq')
abbr('Wq', 'wq')
abbr('WQ', 'wq')
abbr('Qa', 'qa')
abbr('Bd', 'bd')
abbr('bD', 'bd')
abbr('Wqa', 'wqa')

local bind = vim.keymap.set

-- Cancel search highlight
bind('n', '<esc>', ':nohl<cr>:redraws!<cr><esc>', { noremap = true, silent = true, desc = 'Hide search' })
bind('n', '<leader><space>', ':let @/=""<cr>:redraws!<cr>', { noremap = true, silent = true, desc = 'Clear search' })

-- Hlsearch next/prev
bind('c', '<F3>', '<c-g>', { noremap = true, desc = 'Next search result' })
bind('n', '<F3>', 'n', { noremap = true, desc = 'Next search result' })
bind('c', '<S-F3>', '<c-t>', { noremap = true, desc = 'Previos search result' })
bind('n', '<S-F3>', 'N', { noremap = true, desc = 'Previous search result' })

-- bind('n', '<c-f>', '/<c-r><c-w>', { desc = 'Search' }) --search word under cursor
bind('n', 'cn', '*``cgn', { desc = 'Change word (forward)' }) -- `:h gn`
bind('n', 'cN', '*``cgN', { desc = 'Change word (backward)' }) -- `:h gN`

-- Redo
bind('n', 'U', ':redo<cr>', { desc = 'Redo' })

-- Keep selection after indent
bind('v', '>', '>gv', { noremap = true, desc = 'Increase selection indentation' })
bind('v', '<', '<gv', { noremap = true, desc = 'Decrease selection indentation' })

-- Selection like in Windows
bind('n', '<S-Up>', 'V')
bind('n', '<S-Down>', 'V')
bind('v', '<S-Up>', 'k')
bind('v', '<S-Down>', 'j')

bind('n', 'H', '^')
bind('n', 'L', '$')

-- Switch between windows.
bind('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window', remap = true })
bind('n', '<C-j>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
bind('n', '<C-k>', '<C-w>k', { desc = 'Move to the top window', remap = true })
bind('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window', remap = true })

-- Resize splits
bind('n', '<m-[>', '<cmd>vertical resize -5<cr>')
bind('n', '<m-]>', '<cmd>vertical resize +5<cr>')

-- Show message log
bind('n', '<leader>m', function() require('functions').show_messages() end, { desc = 'Show Messages' })
bind('n', '<leader>M', 'g<', { desc = 'Show Last Message' })

-- Show Neovim info - news.txt
bind('n', '<leader>i', '<cmd>vert bo help news.txt<cr>', { desc = 'Show Neovim News' })

-- Use <Esc> to exit terminal mode
bind('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Plugins
bind('n', '<leader>pl', function() vim.pack.update() end, { desc = 'Update plugins' })
