-- Try to load "env" file
local ok, _ = pcall(require, 'user.env')

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
local time = os.date('*t')
if time.hour > 19 or time.hour < 5 then
	vim.cmd('colorscheme rose-pine-moon')
else
	vim.cmd('colorscheme rose-pine-dawn')
end
