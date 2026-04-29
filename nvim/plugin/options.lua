local opt = vim.opt
local g = vim.g

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Visuals
if vim.fn.has('win32') == 1 then
	opt.guifont = 'Cascadia Code NF:h14'
	opt.background = 'light'
else
	opt.guifont = 'CaskaydiaCove NF:h14'
	-- opt.background = g.neovide and 'light' or 'dark'
end

opt.number = true
opt.laststatus = 3
opt.showtabline = 0
opt.tabline = '%t'
opt.ruler = false
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.showmode = false
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.smoothscroll = true
opt.pumborder = 'solid'

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.shortmess:append('S') -- Don't show searchcount in message area

opt.list = false

opt.listchars = {
	tab = '→ ',
	nbsp = '⎵',
	space = '·',
}

opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '▾',
	foldclose = '▸',
	foldsep = ' ',
	diff = '╱',
}

opt.diffopt:append('algorithm:histogram,vertical,linematch:60')

-- Indentation & tabs
opt.smartindent = true
opt.autoindent = true
opt.expandtab = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- experimental
-- opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Folding
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = ''

-- Misc
opt.swapfile = false
opt.hidden = true
opt.splitright = true
opt.scrolloff = 5
opt.confirm = true
opt.inccommand = 'split'
-- opt.exrc = true
-- opt.secure = true

-- Grep arguments
if vim.fn.executable('rg') == 1 then
	opt.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
	opt.grepformat = '%f:%l:%c:%m'
end

-- Terminal
if vim.fn.executable('nu') == 1 then
	opt.shell = 'nu'
	opt.shellcmdflag = '--login --stdin --no-newline -c'
	opt.shellpipe = '|complete|update stderr {ansi strip}|tee {get stderr|save --force --raw %s}|into record'
	opt.shellredir = 'out+err> %s'
	opt.shelltemp = false
	opt.shellxescape = ''
	opt.shellxquote = ''
	opt.shellquote = ''
end

-- Globals
g.showcmd = false
g.winborder = 'single'

-- Disable unused providers
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0

-- Disable unused vim plugins
g.loaded_vscode_diff = 1
g.loaded_tar = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
-- g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_rplugin = 1
g.loaded_rrhelper = 1
g.loaded_remote_plugins = 1
g.loaded_2html_plugin = 1

if g.neovide then
	g.neovide_floating_blur_amount_x = 2.0
	g.neovide_floating_blur_amount_y = 2.0
	g.neovide_floating_corner_radius = 0.2
	g.neovide_floating_shadow = false
end
