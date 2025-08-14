vim.g.mapleader = " "

-- Appearance
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.tabline = "%t"
vim.opt.ruler = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- Always show signcolumn
vim.opt.showmode = false
vim.g.showcmd = false
vim.g.winborder = 'single'
vim.o.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.clipboard = "unnamedplus"

vim.opt.list = true

vim.opt.listchars = {
	tab = "——▸",
	nbsp = "⎵",
	space = "·",
}

vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = " ",
}

-- Indentation & tabs
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

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
if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
	vim.opt.grepformat = "%f:%l:%c:%m"
end

-- Terminal
if vim.fn.executable("nu") == 1 then
	vim.opt.shell = "nu"
	vim.opt.shellxquote = ""
	vim.opt.shellquote = ""
end
