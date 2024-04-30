-- Colored brace pairs
local Plugin = {
	'hiphish/rainbow-delimiters.nvim',
}
Plugin.cond = false
Plugin.event = { 'BufRead', 'BufNewFile' }

function Plugin.config()
	local rainbow_delimiters = require('rainbow-delimiters')

	vim.g.rainbow_delimiters = {
		strategy = {
			[''] = rainbow_delimiters.strategy['global'],
		},
		query = {
			[''] = 'rainbow-delimiters',
			lua = 'rainbow-blocks',
		},
		highlight = {
			'RainbowDelimiterRed',
			'RainbowDelimiterYellow',
			'RainbowDelimiterBlue',
			'RainbowDelimiterOrange',
			'RainbowDelimiterGreen',
			'RainbowDelimiterViolet',
			'RainbowDelimiterCyan',
		},
	}
end

return Plugin
