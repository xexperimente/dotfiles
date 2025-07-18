vim.cmd.language('en_US.UTF-8')

-- Leader key
vim.g.mapleader = ' '

-- Visuals
vim.opt.guifont = 'Cascadia Code NF:h14'
vim.opt.number = true
vim.opt.wrap = false
-- vim.opt.background = 'dark' -- (vim.g.nvy and 'light' or 'dark')
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- Always show signcolumn
vim.opt.showmode = false -- Don't show mode in message area
vim.g.showcmd = false
vim.g.winborder = 'single'
vim.o.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess:append('S') -- Don't show searchcount in message area

-- Indentation & tabs
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- UI
vim.opt.laststatus = 3 -- 2
vim.opt.showtabline = 0 -- 2
vim.opt.tabline = '%t'
vim.opt.ruler = false
vim.opt.rulerformat = ''

vim.opt.list = true

vim.opt.listchars = {
	tab = '——▸',
	nbsp = '⎵',
	space = '·',
}

vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '▾',
	foldclose = '▸',
	foldsep = ' ',
}

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = 'v:lua.require("xexperimente.core.foldtext").custom_foldtext()'

-- Misc
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.scrolloff = 5
vim.opt.confirm = true

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

-- Grep arguments
if vim.fn.executable('rg') == 1 then
	vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
	vim.opt.grepformat = '%f:%l:%c:%m'
end

-- Terminal
if vim.fn.executable('nu') == 1 then
	vim.opt.shell = 'nu'
	vim.opt.shellxquote = ''
	vim.opt.shellquote = ''
end

if vim.g.neovide then
	local bg = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name('Normal') }).bg

	vim.g.neovide_floating_shadow = false
	vim.g.neovide_title_background_color = string.format('%x', bg)
	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 8
	vim.g.neovide_padding_left = 8
end
