local Lazy = {}

function Lazy.install(path)
	if not vim.loop.fs_stat(path) then
		vim.notify('Installing lazy.nvim...', vim.log.levels.INFO)
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
		print('Done')
	end
end

function Lazy.setup(plugins)
	Lazy.install(Lazy.path)
	Lazy.init()

	require('lazy').setup(plugins, Lazy.opts)
end

function Lazy.init()
	vim.opt.rtp:prepend(Lazy.path)

	vim.keymap.set('n', '<leader>pl', ':Lazy<cr>', { desc = 'Open Lazy' })
	vim.keymap.set('n', '<leader>pp', ':Lazy profile<cr>', { desc = 'Profile Plugins' })
	vim.keymap.set('n', '<leader>pi', ':Lazy install<cr>', { desc = 'Install plugins' })
	vim.keymap.set('n', '<leader>pu', ':Lazy update<cr>', { desc = 'Update plugins' })
end

Lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

Lazy.opts = {
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		notify = false,
		concurency = 1,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false,
	},
	install = {
		missing = true,
		colorscheme = { 'rose-pine-dawn' },
	},
	rocks = { enabled = false },
	ui = {
		border = require('user.env').border,
		title = ' lazy.nvim ',
		size = {
			width = 0.85,
		},
		icons = {
			lazy = '',
		},
	},
	performance = {
		readme = {
			enabled = false,
		},
		rtp = {
			-- Disable some builtin vim plugins
			disabled_plugins = {
				'2html_plugin',
				'bugreport',
				'getscript',
				'getscriptPlugin',
				'gzip',
				'logipat',
				'netrw',
				'netrwPlugin',
				'netrwSettings',
				'netrwFileHandlers',
				'man',
				'matchit',
				'matchparen',
				'rplugin',
				'rrhelper',
				'spellfile',
				'spellfile_plugin',
				'tar',
				'tarPlugin',
				'tohtml',
				'tutor',
				'vimball',
				'vimballPlugin',
				'zip',
				'zipPlugin',
			},
		},
	},
}

Lazy.setup({
	{ import = 'specs' },
	{ import = 'specs.local' },
})

local user_grp = vim.api.nvim_create_augroup('LazyUserGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lazy',
	desc = 'Quit lazy with <esc>',
	callback = function()
		vim.keymap.set('n', '<esc>', function() vim.api.nvim_win_close(0, false) end, { buffer = true, nowait = true })
	end,
	group = user_grp,
})
