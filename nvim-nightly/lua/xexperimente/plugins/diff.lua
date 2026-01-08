vim.pack.add({ 'https://github.com/esmuellert/codediff.nvim' })

require('codediff').setup({})

local bind = vim.keymap.set

bind('n', '<leader>df', '<cmd>CodeDiff file HEAD<cr>', { desc = 'Compare file with last commit' })
bind('n', '<leader>dF', '<cmd>CodeDiff file HEAD~1<cr>', { desc = 'Compare file to previous commit' })
bind('n', '<leader>dh', '<cmd>CodeDiff<cr>', { desc = 'Show git status' })
