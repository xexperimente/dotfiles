vim.g.mapleader = ' '

-- Visuals
if vim.fn.has('win32') then
	vim.opt.guifont = 'Cascadia Code NF:h14'
	vim.opt.background = 'light'
else
	vim.opt.guifont = 'CaskaydiaCove NF:h14'
	if vim.g.neovide then
		vim.opt.background = 'light'
	else
		vim.opt.background = 'dark'
	end
end

-- Appearance
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.tabline = '%t'
vim.opt.ruler = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- Always show signcolumn
vim.opt.showmode = false
vim.g.showcmd = false
vim.g.winborder = 'single'
vim.o.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess:append('S') -- Don't show searchcount in message area

vim.opt.clipboard = 'unnamedplus'

vim.opt.list = true

vim.opt.listchars = {
	tab = '→ ', -- '——▸',
	nbsp = '⎵',
	space = '·',
}

vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '▾',
	foldclose = '▸',
	foldsep = ' ',
	diff = '╱',
}

vim.opt.diffopt = {
	'internal',
	'filler',
	'closeoff',
	'vertical',
	'algorithm:histogram',
	'indent-heuristic',
	'linematch:60',
	'inline:char',
}

-- Indentation & tabs
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- experimental
-- vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''

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
	vim.opt.shellcmdflag = '--login --stdin --no-newline -c'
	vim.opt.shellpipe = '|complete|update stderr {ansi strip}|tee {get stderr|save --force --raw %s}|into record'
	vim.opt.shellredir = 'out+err> %s'
	vim.opt.shelltemp = false
	vim.opt.shellxescape = ''
	vim.opt.shellxquote = ''
	vim.opt.shellquote = ''
end

if vim.g.neovide then
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_corner_radius = 0.2
	vim.g.neovide_floating_shadow = false
end
