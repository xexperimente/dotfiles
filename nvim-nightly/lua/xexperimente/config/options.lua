vim.g.mapleader = " "

vim.opt.number = true

vim.opt.clipboard = "unnamedplus"

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

-- Terminal
if vim.fn.executable('nu') == 1 then
	vim.opt.shell = 'nu'
	vim.opt.shellxquote = ''
	vim.opt.shellquote = ''
end
