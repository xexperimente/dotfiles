---@diagnostic disable:undefined-field

local uv = vim.uv or vim.loop
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not uv.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

local opts = {
	spec = {
		import = 'xexperimente.plugins',
	},
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
	},
	rocks = { enabled = false },
	ui = {
		border = 'single',
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
				-- 'man',
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

require('lazy').setup(opts)
