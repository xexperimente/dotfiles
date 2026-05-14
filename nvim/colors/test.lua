-- Color palette
local p = {
	bg = '#232136',
	fg = '#e0def4',
	selection = '#264f78',
	comment = '#908caa',
	keyword = '#eb6f92',
	rose = '#ea9a97',
	string = '#F6C177',
	func = '#7aa2f7',
	variable = '#c0caf5',
	number = '#F6C177',
	type = '#4ec9b0',
	operator = '#cdcdcd',
}

-- Apply colorscheme
vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

vim.o.termguicolors = true

-- Editor highlights
vim.api.nvim_set_hl(0, 'Normal', { fg = p.fg, bg = p.bg })
vim.api.nvim_set_hl(0, 'Visual', { bg = p.selection })
vim.api.nvim_set_hl(0, 'Comment', { fg = p.comment, italic = true })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = p.fg })
vim.api.nvim_set_hl(0, 'Special', { fg = p.fg })

-- Syntax highlights
vim.api.nvim_set_hl(0, 'Keyword', { fg = p.keyword })
vim.api.nvim_set_hl(0, 'String', { fg = p.string })
vim.api.nvim_set_hl(0, 'Function', { fg = p.rose })
vim.api.nvim_set_hl(0, 'Variable', { fg = p.variable })
vim.api.nvim_set_hl(0, 'Number', { fg = p.number })
vim.api.nvim_set_hl(0, 'Type', { fg = p.string })
vim.api.nvim_set_hl(0, 'Operator', { fg = p.operator })
vim.api.nvim_set_hl(0, 'Statement', { fg = p.keyword })
vim.api.nvim_set_hl(0, 'Constant', { fg = p.fg })
vim.api.nvim_set_hl(0, 'Identifier', { fg = p.fg })
vim.api.nvim_set_hl(0, 'PreProc', { fg = p.func })

-- Treesitter highlights
vim.api.nvim_set_hl(0, '@keyword', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@string', { link = 'String' })
vim.api.nvim_set_hl(0, '@function', { link = 'Function' })
vim.api.nvim_set_hl(0, '@variable', { link = 'Variable' })
vim.api.nvim_set_hl(0, '@number', { link = 'Number' })
vim.api.nvim_set_hl(0, '@type', { link = 'Type' })
vim.api.nvim_set_hl(0, '@operator', { link = 'Operator' })
vim.api.nvim_set_hl(0, '@comment', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'cppModifier', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'cppStructure', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'cppModule', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'cInclude', { fg = p.type })
vim.api.nvim_set_hl(0, 'cIncluded', { link = 'cInclude' })
