vim.schedule(function()
	vim.pack.add({
		{ src = 'https://github.com/nvimdev/guard.nvim' },
		{ src = 'https://github.com/nvimdev/guard-collection' },
	}, {
		load = require('pack').on_event('BufReadPost', { 'mason.nvim', 'guard.nvim', 'guard-collection' }, function()
			local ft = require('guard.filetype')

			---@diagnostic disable: call-non-callable
			ft('lua'):fmt('stylua'):lint('selene')

			ft('json,jsonc'):fmt('deno_fmt')
			ft('rust'):fmt('rustfmt')
			ft('cpp,hpp'):fmt('clang-format')
			---@diagnostic enable
		end),
	})
end)
