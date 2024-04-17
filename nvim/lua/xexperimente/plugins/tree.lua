local Plugin = { 'nvim-tree/nvim-tree.lua' }

Plugin.cmd = { 'NvimTreeToggle', 'NvimTreeOpen' }

Plugin.dependencies = {
	'nvim-tree/nvim-web-devicons',
	'projekt0n/circles.nvim',
}

Plugin.keys = {
	{ '<leader>fe', '<cmd>NvimTreeToggle<cr>', desc = 'Open file explorer' },
}

function Plugin.opts()
	return {
		sync_root_with_cwd = true,
		actions = {
			open_file = {
				quit_on_open = true,
			},
			change_dir = {
				global = true,
			},
		},
		renderer = {
			root_folder_modifier = ':p:~',
			icons = {
				symlink_arrow = ' → ',
				show = {
					file = true,
					folder = false,
				},
				-- glyphs = require('circles').get_nvimtree_glyphs(),
				-- glyphs = {
				-- 	folder = {
				-- arrow_closed = '▸',
				-- arrow_open = '▾',
				-- 	},
				-- },
			},
			special_files = {
				'Cargo.toml',
				'Makefile',
				'README.md',
				'readme.md',
				'lazy-lock.json',
				'stylua.toml',
				'selene.toml',
				'vim.toml',
			},
		},
	}
end

return Plugin
