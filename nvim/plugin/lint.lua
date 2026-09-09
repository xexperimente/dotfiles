vim.defer_fn(function()
	vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

	local lint = require('lint')

	lint.linters_by_ft = {
		lua = { 'selene' },
	}

	vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
		group = vim.api.nvim_create_augroup('xexperimente/lint', { clear = true }),
		callback = function(args)
			-- Do not lint in diff mode
			if vim.opt.diff:get() then return end

			vim.api.nvim_buf_call(args.buf, function() lint.try_lint(nil, { ignore_errors = true }) end)
		end,
	})

	vim.api.nvim_create_user_command('Lint', function() lint.try_lint() end, { desc = 'Lint' })

	vim.api.nvim_create_user_command('LintInfo', function()
		local filetype = vim.bo.filetype
		local linters = lint.linters_by_ft[filetype] or {}
		if #linters == 0 then
			vim.notify(string.format('%s: no linter', filetype), vim.log.levels.INFO)
		else
			vim.notify(string.format('%s: linters: %s', filetype, table.concat(linters, ', ')), vim.log.levels.INFO)
		end
	end, { desc = 'Linter info' })
end, 0)
