vim.pack.add({
	'https://github.com/VonHeikemen/searchbox.nvim',
})

local opts = {
	defaults = {
		show_matches = true,
	},
	popup = {
		position = {
			row = '70%',
			col = '50%',
		},
		size = 50,
		border = {
			style = vim.g.winborder,
			text = {
				top = { { ' Search ', 'FloatTitle' } },
				top_align = 'center',
			},
			padding = { 0, 1 },
		},
		win_options = {
			winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
		},
	},
	hooks = {
		after_mount = function(input)
			local opt = { buffer = input.bufnr }

			-- <F3> / <S-F3> to cycle matches
			vim.keymap.set('i', '<F3>', '<Plug>(searchbox-next-match)', opt)
			vim.keymap.set('i', '<S-F3>', '<Plug>(searchbox-prev-match)', opt)
		end,
	},
}

local sb = require('searchbox')
local exp = vim.fn.expand
local bind = vim.keymap.set

sb.setup(opts)

bind('n', '<c-f>', '<cmd>SearchBoxMatchAll<cr>', { desc = 'Searchbox' })
bind('n', '<c-s-f>', function() sb.match_all({ default_value = exp('<cword>') }) end, { desc = 'Searchbox(cword)' })
bind('v', '<c-f>', 'y:SearchBoxMatchAll -- <C-r>"<cr>', { desc = 'Searchbox' })
bind('n', '<leader>r', '<cmd>SearchBoxReplace<cr>', { desc = 'Replace' })
bind('n', '<leader>R', function() sb.replace({ default_value = exp('<cword>') }) end, { desc = 'Replace(cword)' })
bind('v', '<leader>r', 'y:SearchBoxReplace -- <C-r>"<cr>', { desc = 'Replace' })
