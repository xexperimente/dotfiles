vim.schedule(function()
	local function ensure_list(specs)
		return (type(specs) == 'string' or (type(specs) == 'table' and specs.src)) and { specs } or specs
	end
	local function on_event(events, pkg_name, setup_fn)
		return function()
			vim.api.nvim_create_autocmd(events, {
				once = true,
				callback = function()
					for _, p in ipairs(ensure_list(pkg_name)) do
						vim.cmd.packadd(p)
					end
					if setup_fn then setup_fn() end
				end,
			})
		end
	end

	vim.pack.add({
		{ src = 'https://github.com/nvimdev/guard.nvim' },
		{ src = 'https://github.com/nvimdev/guard-collection' },
	}, {
		load = on_event('BufReadPost', { 'guard.nvim', 'guard-collection' }, function()
			local ft = require('guard.filetype')

			ft('lua'):fmt('stylua'):lint('selene')

			ft('json,jsonc'):fmt('deno_fmt')

			ft('rust'):fmt('rustfmt')
		end),
	})
end)
