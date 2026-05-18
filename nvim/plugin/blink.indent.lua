vim.schedule(function()
	vim.pack.add({ 'https://github.com/saghen/blink.indent' })

	--- @module 'blink.indent'
	--- @type blink.indent.Config
	local opts = {
		blocked = {
			filetypes = { 'snacks_picker_preview', include_defaults = true },
		},
		static = {
			enabled = false,
		},
		scope = {
			highlights = { 'BlinkIndentScope' },
		},
	}

	local indent = require('blink.indent')

	indent.setup(opts)

	vim.keymap.set('n', '<leader>ui', function()
		local enabled = indent.is_enabled()
		indent.enable(not enabled)
	end, { desc = 'Toggle indent guides' })
end)
