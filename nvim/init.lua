-- Experimental lua module loader
-- see :help vim.loader.enable()
vim.loader.enable()

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
if env.use_dark_theme() then
	vim.cmd('colorscheme rose-pine-moon')
else
	vim.cmd('colorscheme rose-pine-dawn')
end
