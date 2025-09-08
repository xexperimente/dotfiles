-- local function gh(pkg) return { src = 'https://github.com/' .. pkg, version = vim.version.range('*') } end
local function gh(pkg) return { src = 'https://github.com/' .. pkg } end

vim.pack.add({
	gh('nvim-mini/mini.nvim'),
})

local opts = {
	patterns = {
		highlighters = {
			fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
			hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
			todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
			note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
			hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
		},
	},
	surround = { mappings = { update_n_lines = nil } },
	diff = {
		view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '┃' } },
	},
	indentscope = {
		draw = {
			animation = require('mini.indentscope').gen_animation.quadratic({
				easing = 'out',
				duration = 50,
				unit = 'total',
			}),
		},
	},
}

local bind = vim.keymap.set

require('mini.ai').setup()
require('mini.diff').setup(opts.diff)
require('mini.git').setup()
require('mini.icons').setup()
require('mini.indentscope').setup(opts.indentscope)
require('mini.splitjoin').setup()
require('mini.surround').setup(opts.surround)
require('mini.hipatterns').setup(opts.patterns)

bind('n', '<leader>uj', '<cmd>lua MiniSplitjoin.toggle()<cr>', { desc = 'Toggle splitjoin' })
bind('n', '<leader>gc', '<cmd>lua MiniDiff.toggle_overlay()<cr>', { desc = 'Show diff overlay' })

-- Setup Diff summary string
local format_summary = function(data)
	local summary = vim.b[data.buf].minidiff_summary

	if summary == nil then return end

	local t = {}
	if summary.add > 0 then table.insert(t, ' ' .. summary.add) end
	if summary.change > 0 then table.insert(t, ' ' .. summary.change) end -- 
	if summary.delete > 0 then table.insert(t, ' ' .. summary.delete) end
	vim.b[data.buf].minidiff_summary_string = table.concat(t, ' ')
end

vim.api.nvim_create_autocmd('User', { pattern = 'MiniDiffUpdated', callback = format_summary })
