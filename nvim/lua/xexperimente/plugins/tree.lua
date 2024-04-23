-- File explorer
local Plugin = { 'tamago324/lir.nvim' }
local user = {}

Plugin.dependencies = {
	{ 'nvim-lua/plenary.nvim' },
}

function Plugin.init()
	-- disable netrw
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	local bind = vim.keymap.set
	local toggle = user.toggle

	-- Open file manager
	bind('n', '<leader>fe', '<cmd>FileExplorer<cr>')
	bind('n', '<leader>fa', '<cmd>FileExplorer!<cr>')

	vim.api.nvim_create_user_command(
		'FileExplorer',
		function(input) toggle(input.args, input.bang) end,
		{ bang = true, nargs = '?' }
	)
end

function Plugin.config()
	local lir = require('lir')

	local actions = require('lir.actions')
	local marks = require('lir.mark.actions')
	local clipboard = require('lir.clipboard.actions')

	lir.setup({
		on_init = user.on_init,
		mappings = {
			['l'] = actions.edit,
			['es'] = actions.split,
			['ev'] = actions.vsplit,
			['et'] = actions.tabedit,

			['h'] = actions.up,
			['q'] = actions.quit,

			['<left>'] = actions.up,
			['<right>'] = actions.edit,
			['<enter>'] = actions.edit,
			['<esc>'] = actions.quit,

			['za'] = actions.toggle_show_hidden,
			['i'] = actions.newfile,
			['o'] = actions.mkdir,
			['d'] = actions.delete,
			['Y'] = actions.yank_path,
			['cl'] = actions.rename,

			['<Tab>'] = marks.toggle_mark,

			['cc'] = clipboard.copy,
			['cx'] = clipboard.cut,
			['cv'] = clipboard.paste,
		},
		show_hidden_files = false,
		ignore = {}, -- { ".DS_Store", "node_modules" } etc.
		hide_cursor = true,
		float = {
			winblend = 0,
			win_opts = function()
				return {
					border = 'rounded',
					zindex = 46,
				}
			end,
			curdir_window = {
				enable = false,
				highlight_dirname = false,
			},
		},
	})
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

-- local Plugin = { 'nvim-tree/nvim-tree.lua' }

-- Plugin.cmd = { 'NvimTreeToggle', 'NvimTreeOpen' }

-- Plugin.dependencies = {
-- 	'nvim-tree/nvim-web-devicons',
-- 	'projekt0n/circles.nvim',
-- }

-- Plugin.keys = {
-- 	{ '<leader>fe', '<cmd>NvimTreeToggle<cr>', desc = 'Open file explorer' },
-- }

-- function Plugin.opts()
-- 	return {
-- 		sync_root_with_cwd = true,
-- 		actions = {
-- 			open_file = {
-- 				quit_on_open = true,
-- 			},
-- 			change_dir = {
-- 				global = true,
-- 			},
-- 		},
-- 		renderer = {
-- 			root_folder_modifier = ':p:~',
-- 			icons = {
-- 				symlink_arrow = ' → ',
-- 				show = {
-- 					file = true,
-- 					folder = false,
-- 				},
-- 				-- glyphs = require('circles').get_nvimtree_glyphs(),
-- 				-- glyphs = {
-- 				-- 	folder = {
-- 				-- arrow_closed = '▸',
-- 				-- arrow_open = '▾',
-- 				-- 	},
-- 				-- },
-- 			},
-- 			special_files = {
-- 				'Cargo.toml',
-- 				'Makefile',
-- 				'README.md',
-- 				'readme.md',
-- 				'lazy-lock.json',
-- 				'stylua.toml',
-- 				'selene.toml',
-- 				'vim.toml',
-- 			},
-- 		},
-- 	}
-- end

-- return Plugin
