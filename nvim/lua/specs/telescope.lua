local Plugin = { 'nvim-telescope/telescope.nvim' }

Plugin.lazy = true

Plugin.cmd = { 'Telescope' }

Plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'nvim-telescope/telescope-ui-select.nvim',
	'ghassan0/telescope-glyph.nvim',
	{ 'theprimeagen/harpoon', branch = 'harpoon2' },
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
	},
}

function Plugin.init()
	local bind = vim.keymap.set

	bind('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Open buffers' })
	bind('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
	bind('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
	bind('n', '<leader>fc', '<cmd>Telescope highlights<cr>', { desc = 'Find colors' })
	bind('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Find in help' })
	bind('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = 'Keymap help' })
	bind('n', '<leader>fD', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace Diagnostics' })
	bind('n', '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Diagnostics' })
	bind('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent files' })
	bind('n', '<leader>fG', '<cmd>Telescope grep_string<cr>', { desc = 'Grep string' })
	bind('n', '<leader>fs', '<cmd>Telescope treesitter<cr>', { desc = 'Buffer symbols' })
	bind('n', '<leader>fr', '<cmd>Telescope resume<cr>', { desc = 'Resume last search' })
	bind('n', '<leader>fm', '<cmd>Telescope marks<cr>', { desc = 'Show marks' })
	bind(
		'n',
		'<leader>fC',
		'<cmd>Telescope glyph layout_strategy=vertical<cr>',
		{ desc = 'Find character/glyph' }
	)
end

function Plugin.config(_, _)
	local telescope = require('telescope')
	local actions = require('telescope.actions')

	telescope.setup({
		pickers = {
			find_files = { layout_strategy = 'vertical', previewer = false },
			buffers = { layout_strategy = 'vertical', previewer = false },
			oldfiles = { layout_strategy = 'vertical', previewer = false },
			help_tags = {
				layout_strategy = 'horizontal',
				previewer = true,
				layout_config = {
					height = 0.7,
					width = 0.7,
					preview_width = 60,
					mirror = false,
				},
			},
			highlights = {
				layout_strategy = 'horizontal',
				previewer = true,
				layout_config = {
					height = 0.7,
					width = 0.7,
					preview_width = 60,
					mirror = false,
				},
			},
			marks = {
				attach_mappings = function(_, map)
					map({ 'i', 'n' }, '<M-d>', require('telescope.actions').delete_mark)
					return true
				end,
			},
		},
		defaults = {
			path_display = { shorten = 7 },
			prompt_prefix = '  ',
			selection_caret = '  ',
			completion = {
				autocomplete = false,
			},
			layout_config = {
				prompt_position = 'bottom',
				vertical = {
					prompt_position = 'bottom',
					width = 0.5,
					height = 0.5,
				},
			},
			mappings = {
				i = {
					['<Esc>'] = actions.close,
					['<C-p>'] = require('telescope.actions.layout').toggle_preview,
					['<C-Right>'] = actions.select_vertical,
					['<C-Down>'] = actions.select_horizontal,
					['<C-h>'] = 'which_key',
				},
			},
		},
		extensions = {
			['ui-select'] = { require('telescope.themes').get_dropdown({}) },
			['fzf'] = {
				fuzzy = true,
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
			},
			['glyph'] = {
				action = function(glyph)
					vim.fn.setreg('*', glyph.value)
					vim.api.nvim_put({ glyph.value }, 'c', false, true)
				end,
			},
		},
	})

	require('harpoon').setup()

	telescope.load_extension('glyph')
	telescope.load_extension('ui-select')
	telescope.load_extension('fzf')
end

return Plugin
