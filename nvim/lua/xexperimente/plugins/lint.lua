local Plugin = { 'mfussenegger/nvim-lint' }
local user = {}

Plugin.event = { 'BufReadPre', 'BufNewFile' } --'VeryLazy'

Plugin.opts = {
	events = { 'BufWritePost', 'BufEnter', 'InsertLeave' },
	linters_by_ft = {
		lua = { 'selene' },
	},
	linters = {
		selene = {
			cmd = 'selene.cmd',
		},
	},
}

function Plugin.config(_, opts)
	local lint = require('lint')

	lint.linters_by_ft = opts.linters_by_ft or {}

	for name, linter in pairs(opts.linters) do
		if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
			lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
		else
			lint.linters[name] = linter
		end
	end

	lint.try_lint()

	vim.api.nvim_create_autocmd(opts.events, {
		group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
		callback = user.debounce(100, user.lint), --function() lint.try_lint() end,
	})
end

function Plugin.init()
	vim.keymap.set('n', '<leader>ll', function()
		vim.notify('Runing lint', vim.log.levels.INFO)
		user.lint()
	end, { desc = 'Lint' })
end

function user.debounce(ms, fn)
	local timer = vim.loop.new_timer()
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

--function M.lint()
--	local names = lint.linters_by_ft[vim.bo.filetype] or {}
--	local ctx = { filename = vim.api.nvim_buf_get_name(0) }
--	ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
--	names = vim.tbl_filter(function(name)
--		local linter = lint.linters[name]
--		return linter
--			and not (
--				type(linter) == 'table'
--				and linter.condition
--				and not linter.condition(ctx)
--			)
--	end, names)
--
--	if #names > 0 then lint.try_lint(names) end
--end
