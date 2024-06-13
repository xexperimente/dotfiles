local Plugin = { 'mfussenegger/nvim-lint' }
local user = {}

Plugin.lazy = true
Plugin.event = { 'BufReadPre', 'BufNewFile' } --'VeryLazy'

Plugin.opts = {
	events = { 'BufWritePost', 'BufEnter', 'InsertLeave' },
	linters_by_ft = {
		lua = { 'selene' },
	},
}

function Plugin.config(_, opts)
	local lint = require('lint')

	lint.linters_by_ft = opts.linters_by_ft or {}

	lint.try_lint()

	vim.api.nvim_create_autocmd(opts.events, {
		group = vim.api.nvim_create_augroup('UserLintCmds', { clear = true }),
		callback = user.debounce(100, user.lint), --function() lint.try_lint() end,
	})
end

function Plugin.init()
	vim.keymap.set('n', 'gl', function()
		vim.notify('Linting ... ', vim.log.levels.INFO)
		user.lint()
	end, { desc = 'Lint' })
end

--
function user.debounce(ms, fn)
	local timer = vim.uv.new_timer()
	return function(...)
		local argv = { ... }
		timer:start(ms, 0, function()
			timer:stop()
			vim.schedule_wrap(fn)(unpack(argv))
		end)
	end
end

function user.lint()
	local lint = require('lint')
	local names = lint.linters_by_ft[vim.bo.filetype] or {}

	if #names > 0 then lint.try_lint(names) end
end

return Plugin
