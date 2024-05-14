-- File explorer
local Plugin = { 'tamago324/lir.nvim' }
local user = {}

Plugin.lazy = true

Plugin.keys = {
	'<leader>fe',
	'<leader>fa',
}

Plugin.dependencies = {
	{ 'nvim-lua/plenary.nvim' },
}

function Plugin.init()
	-- disable netrw
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

function Plugin.config()
	local lir = require('lir')

	local actions = require('lir.actions')
	local marks = require('lir.mark.actions')
	local clipboard = require('lir.clipboard.actions')

	local bind = vim.keymap.set
	local toggle = user.toggle

	lir.setup({
		on_init = user.on_init,
		mappings = {
			['<C-Down>'] = actions.split,
			['<C-Right>'] = actions.vsplit,
			['et'] = actions.tabedit,

			['q'] = actions.quit,

			['<BS>'] = actions.up,
			['h'] = actions.up,
			['<left>'] = actions.up,
			['<right>'] = actions.edit,
			['<enter>'] = actions.edit,
			['<esc>'] = actions.quit,

			['.'] = actions.toggle_show_hidden,
			['N'] = actions.newfile,
			['K'] = actions.mkdir,
			['D'] = actions.delete,
			['Y'] = actions.yank_path,
			['<F2>'] = actions.rename,

			['J'] = function()
				marks.toggle_mark()
				vim.cmd('normal! j')
			end,

			['C'] = clipboard.copy,
			['X'] = clipboard.cut,
			['P'] = clipboard.paste,
		},
		show_hidden_files = false,
		ignore = {}, -- { ".DS_Store", "node_modules" } etc.
		hide_cursor = true,
		float = {
			winblend = 0,
			win_opts = function()
				return {
					border = 'solid',
					zindex = 46,
					width = 54,
				}
			end,
			curdir_window = {
				enable = true,
				highlight_dirname = false,
			},
		},
	})

	-- Open file manager
	bind('n', '<leader>fe', '<cmd>FileExplorer<cr>')
	bind('n', '<leader>fa', '<cmd>FileExplorer!<cr>')

	vim.api.nvim_create_user_command(
		'FileExplorer',
		function(input) toggle(input.args, input.bang) end,
		{ bang = true, nargs = '?' }
	)
end

function user.on_init()
	local noremap = { remap = false, silent = true, buffer = true }
	local remap = { remap = true, silent = true, buffer = true }
	local bind = vim.keymap.set

	local mark = "<esc><cmd>lua require('lir.mark.actions').toggle_mark('v')<cr>gv<C-c>"

	bind('n', 'v', 'V', noremap)
	bind('x', 'q', '<esc>', noremap)

	bind('x', '<Tab>', mark, noremap)
	bind('x', 'cc', mark .. 'cc', remap)
	bind('x', 'cx', mark .. 'cx', remap)

	bind('n', '<S-Tab>', 'gv<Tab>', remap)

	--vim.wo.statusline = require('local.statusline').get_status('short')    -- custom folder icon
end

function user.toggle(cwd, root)
	--local env = require('user.env')
	local path = ''

	if root then
		path = vim.fn.getcwd()
	elseif cwd == '' then
		path = vim.fn.expand('%:p:h')
	else
		path = cwd
	end

	--if vim.o.lines > env.small_screen_lines then
	require('lir.float').toggle(path)
	--else
	--	vim.cmd({ cmd = 'edit', args = { path } })
	--end
end

return Plugin
