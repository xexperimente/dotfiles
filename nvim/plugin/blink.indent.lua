local add_on_event = require('pack').add_on_event

add_on_event('UIEnter', {
	{
		src = 'saghen/blink.indent',

		opts = {
			blocked = {
				filetypes = { 'snacks_picker_preview', include_defaults = true },
			},
			static = {
				enabled = false,
			},
			scope = {
				highlights = { 'BlinkIndentScope' },
			},
		},
		on_setup = function()
			vim.keymap.set('n', '<leader>ui', function()
				local indent = require('blink.indent')
				local enabled = indent.is_enabled()
				indent.enable(not enabled)
			end, { desc = 'Toggle indent guides' })
		end,
	},
})
