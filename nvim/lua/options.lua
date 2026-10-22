vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.showcmd = false

local border = 'single'

-- Visuals
vim.g.winborder = border
vim.o.winborder = border
vim.o.pumborder = border
vim.o.number = true
vim.o.laststatus = 3
vim.o.showtabline = 0
vim.o.showmode = false
vim.o.tabline = '%t'
vim.o.ruler = false
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.smoothscroll = true
vim.o.cmdheight = 0

-- Indentation & tabs
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.opt.shortmess:append('w') -- Flatten write message
vim.opt.shortmess:append('s') -- Don't show search flip message
vim.opt.shortmess:append('S') -- Don't show search count

---@diagnostic disable-next-line: missing-fields
vim.opt.listchars = {
	tab = '→ ',
	nbsp = '⎵',
	trail = '·',
	space = '·',
}

---@diagnostic disable-next-line: missing-fields
vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '▾',
	foldclose = '▸',
	foldsep = ' ',
	diff = '╱',
}

vim.opt.diffopt:append('algorithm:histogram,vertical,linematch:60')

-- Folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''

-- Misc
vim.o.swapfile = false
vim.o.hidden = true
vim.o.splitright = true
vim.o.scrolloff = 5
vim.o.confirm = true
vim.o.inccommand = 'split'
vim.o.exrc = true
-- opt.secure = true

vim.schedule(function()
	-- Grep arguments
	if vim.fn.executable('rg') == 1 then
		vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
		vim.o.grepformat = '%f:%l:%c:%m'
	end

	-- Terminal
	if vim.fn.executable('nu') == 1 then
		vim.o.shell = 'nu'
		vim.o.shellcmdflag = '--login --stdin --no-newline -c'
		vim.o.shellpipe = '|complete|update stderr {ansi strip}|tee {get stderr|save --force --raw %s}|into record'
		vim.o.shellredir = 'out+err> %s'
		vim.o.shelltemp = false
		vim.o.shellxescape = ''
		vim.o.shellxquote = ''
		vim.o.shellquote = ''
	end
end)

-- Silence `wl-paste`'s "Nothing is copied" stderr on an empty Wayland clipboard.
if vim.fn.has('linux') == 1 and vim.env.WAYLAND_DISPLAY then
	vim.g.clipboard = {
		name = 'wl-clipboard',
		copy = {
			['+'] = 'wl-copy --type text/plain',
			['*'] = 'wl-copy --primary --type text/plain',
		},
		paste = {
			['+'] = { 'sh', '-c', 'wl-paste --no-newline 2>/dev/null || true' },
			['*'] = { 'sh', '-c', 'wl-paste --primary --no-newline 2>/dev/null || true' },
		},
		cache_enabled = true,
	}
end

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- Disable unused vim plugins
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_tutor_mode_plugin = 1
-- g.loaded_matchit = 1

if vim.g.neovide then
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_corner_radius = 0.2
	vim.g.neovide_floating_shadow = false
end
