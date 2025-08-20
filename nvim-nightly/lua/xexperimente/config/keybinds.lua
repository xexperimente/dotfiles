local bind = vim.keymap.set

local abbr = vim.cmd.cnoreabbrev

-- Allow misspellings
abbr('qw', 'wq')
abbr('Wq', 'wq')
abbr('WQ', 'wq')
abbr('Qa', 'qa')
abbr('Bd', 'bd')
abbr('bD', 'bd')

bind('n', '<leader>r', '<cmd>restart<cr>', {})

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

-- PackUpdate
vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
	bind('n', 'q', '<c-w>q', { buffer = 0 })
	bind('n', 'w', '<cmd>wq<cr>', { buffer = 0 })
end, {})

bind('n', '<leader>pl', '<cmd>PackUpdate<cr>')
bind('n', '<leader>pu', '<cmd>PackUpdate<cr>')
