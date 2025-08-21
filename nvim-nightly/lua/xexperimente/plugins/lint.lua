vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

local lint = require('lint')

lint.linters_by_ft = {
	lua = { 'selene' },
}

lint.try_lint()

function start_lint()
	local names = lint.linters_by_ft[vim.bo.filetype] or {}

	if #names > 0 then lint.try_lint(names) end
end

local bind = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('LintCommands', { clear = true })

bind('n', 'gl', function()
	vim.notify('Linting ... ', vim.log.levels.INFO, { title = 'Linter' })
	start_lint()
end, { desc = 'Lint' })

autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave', 'TextChanged' }, {
	group = augroup,
	callback = Snacks.util.debounce(start_lint, { ms = 100 }),
})
