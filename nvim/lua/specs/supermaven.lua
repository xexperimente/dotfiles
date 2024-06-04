local Plugin = { 'supermaven-inc/supermaven-nvim' }

Plugin.lazy = true

Plugin.cmd = { 'SupermavenUseFree', 'SupermavenLogout' }

Plugin.opts = {
	keymaps = {
		accept_suggestion = '<C-a>',
		clear_suggestion = '<C-q>',
	},
	-- color = {
	-- 	suggestion_color = '#ea9a97',
	-- 	cterm = 244,
	-- },
}

Plugin.config = true

return Plugin
