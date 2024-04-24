local Plugin = { 'j-hui/fidget.nvim' }

Plugin.cond = false

Plugin.opts = {
	progress = {
		ignore_done_already = true,
		display = {
			render_limit = 10,
			done_icon = 'done',
		},
	},
	integration = {
		['nvim-tree'] = {
			enable = false,
		},
	},
}

function Plugin.config(_, opts)
	local fidget = require('fidget')

	fidget.setup(opts)

	vim.notify = fidget.notify
end

return Plugin
