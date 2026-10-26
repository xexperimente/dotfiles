-- Some settings.
vim.wo.nu = true
vim.wo.rnu = true
vim.o.buflisted = false
---@diagnostic disable-next-line: assign-type-mismatch
vim.opt_local.list = false

-- Add the cfilter plugin.
vim.cmd.packadd('cfilter')
