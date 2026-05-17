local opt = vim.opt

opt.clipboard = 'unnamedplus'

if vim.env.SSH_CONNECTION then
	local function vim_paste()
		local content = vim.fn.getreg('"')
		---@diagnostic disable-next-line: param-type-mismatch
		return vim.split(content, '\n')
	end

	vim.g.clipboard = {
		name = 'OSC 52',
		copy = {
			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
		},
		paste = {
			['+'] = vim_paste,
			['*'] = vim_paste,
		},
	}
end
