local Plugin = { 'nvim-telescope/telescope.nvim' }

-- Plugin.event = 'VeryLazy'
Plugin.lazy = false

Plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'nvim-telescope/telescope-ui-select.nvim',
	'ghassan0/telescope-glyph.nvim',
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
	},
}

function Plugin.opts()
	local actions = require('telescope.actions')

	local defaults = function(title)
		return {
			prompt_title = title,
			results_title = 'Results',
		}
	end

	local dropdown = function(title, previewer)
		return {
			prompt_title = title,
			previewer = previewer or false,
			theme = 'dropdown',
		}
	end

	return {
		defaults = {
			path_display = { shorten = 7 },
			prompt_prefix = '  ',
			selection_caret = '  ',
			completion = {
				autocomplete = false,
			},
			mappings = {
				i = {
					['<Esc>'] = actions.close,
					['<C-p>'] = require('telescope.actions.layout').toggle_preview,
					['<C-Right>'] = actions.select_vertical,
					['<C-Down>'] = actions.select_horizontal,
				},
			},
		},
		pickers = {
			buffers = dropdown(),
			find_files = dropdown(),
			git_files = dropdown(),
			help_tags = dropdown('Help'),
			oldfiles = dropdown('History'),
			treesitter = defaults('Buffer symbols'),
			highlights = { theme = 'dropdown', line_width = 40, wrap_results = true },
			diagnostics = {
				theme = 'dropdown',
				line_width = 65,
				previewer = false,
				wrap_results = true,
			},
			colorscheme = {
				enable_preview = true,--[[ theme = 'dropdown', ]]
			},
			lsp_document_symbols = { path_display = { truncate = 1 } },
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
	}
end

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
	bind('n', '<leader>fC', '<cmd>Telescope glyph<cr>', { desc = 'Find character/glyph' })
end

function Plugin.config(_, opts)
	local telescope = require('telescope')

	telescope.setup(opts)

	telescope.load_extension('glyph')
	telescope.load_extension('ui-select')
	telescope.load_extension('fzf')
end

return Plugin
