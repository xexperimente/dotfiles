-- Try to load "env" file
local ok, env = pcall(require, 'user.env')

if not ok then
  local msg = 'lua/user/env.lua not found. You should probably rename env.sample'
  vim.notify(msg, vim.log.levels.ERROR)
  return
end

require('user.options')
require('user.commands')
require('user.keymaps')
require('user.plugin-manager')

-- Apply theme
vim.cmd('colorscheme rose-pine-dawn')

