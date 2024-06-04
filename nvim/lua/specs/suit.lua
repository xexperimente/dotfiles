local Plugin = { 'doums/suit.nvim' }

Plugin.opts = {
	input = {
		border = require('user.env').border,
		hl_win = 'NormalFloat',
		hl_border = 'FloatBorder',
		hl_prompt = 'NormalFloat',
		width = 20,
	},
	select = {
		border = require('user.env').border,
		hl_win = 'NormalFloat',
		hl_border = 'FloatBorder',
		hl_prompt = 'NormalFloat',
		width = 20,
	},
}

return Plugin
