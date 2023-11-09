local Plugin = { 'f-person/auto-dark-mode.nvim' }

function Plugin.config()
	local auto_dark_mode = require('auto-dark-mode')

	auto_dark_mode.setup({
		update_interval = 1000,
		set_dark_mode = function()
			vim.opt.background = 'dark'
			vim.cmd([[ colorscheme rose-pine-moon ]])
		end,
		set_light_mode = function()
			vim.opt.background = 'light'
			vim.cmd([[ colorscheme rose-pine-dawn ]])
		end,
	})
end

return Plugin
