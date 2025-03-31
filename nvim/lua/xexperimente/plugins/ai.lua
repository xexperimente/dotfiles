local Plugin = { 'milanglacier/minuet-ai.nvim' }

Plugin.cmd = 'Minuet'
Plugin.keys = { '<leader>ua' }

Plugin.opts = {
	virtualtext = {
		keymap = {
			accept = '<A-y>',
			accept_line = '<A-Y>',
			dismiss = '<A-e>',
			prev = '<A-[>',
			next = '<A-]>',
		},
	},
	provider = 'gemini',
}

function Plugin.init()
	vim.keymap.set('n', '<leader>ua', '<cmd>Minuet virtualtext toggle<cr>', { desc = 'Toggle AI suggestions' })
end

return Plugin
