vim.cmd.language('en_US.UTF-8')

-- Leader key
vim.g.mapleader = ' '

-- Appearance
vim.opt.guifont = 'Delugia:h12'
vim.opt.number = true
vim.opt.wrap = false
vim.opt.background = 'light' -- (vim.g.nvy and 'light' or 'dark')
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- Always show signcolumn

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation & tabs
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Completion
vim.opt.completeopt = 'menu,menuone'

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
	foldopen = '▾', -- "",
	foldclose = '▸', -- "",
	foldsep = ' ',
}

-- Statusline
vim.opt.statuscolumn = vim.fn.join({
	'%{%v:lua.require("user.columns").signcolumn()%}%=',
	'%{v:lua.require("user.columns").number()}',
	' %{%v:lua.require("user.columns").foldcolumn()%} ',
}, '')

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- https://www.reddit.com/r/neovim/comments/16xz3q9/comment/k36s1r4/?utm_source=share&utm_medium=web2x&context=3
--vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.o.foldtext = 'v:lua.require("user.columns").foldtext()'

-- Misc
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.scrolloff = 5

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
if vim.fn.has('win32') == 1 then
	vim.opt.shell = 'pwsh.exe'
	vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
	vim.opt.shellxquote = ''
	vim.opt.shellquote = ''
	vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s'
	vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s'
end
