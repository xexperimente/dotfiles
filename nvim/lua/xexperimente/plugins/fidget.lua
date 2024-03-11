local Plugin = { 'j-hui/fidget.nvim' }

Plugin.dependencies = {
	'nvim-tree/nvim-web-devicons',
	'projekt0n/circles.nvim',
}

Plugin.opts = {
	progress = {
		ignore_done_already = true,
		display = {
			render_limit = 10,
			done_icon = 'done',
		},
	},
}

function Plugin.config(_, opts)
	local fidget = require('fidget')

	fidget.setup(opts)

	vim.notify = fidget.notify
end

return Plugin
