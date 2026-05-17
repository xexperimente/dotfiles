local M = {}

local function ensure_list(specs)
	return (type(specs) == 'string' or (type(specs) == 'table' and specs.src)) and { specs } or specs
end

function M.on_event(events, pkg_name, setup_fn)
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
function M.on_cmd(cmd, pkg_name, setup_fn)
	return function()
		vim.api.nvim_create_user_command(cmd, function(data)
			vim.api.nvim_del_user_command(cmd)
			vim.cmd.packadd(pkg_name)
			if setup_fn then setup_fn() end
			vim.cmd(('%s %s'):format(cmd, data.args))
		end, { nargs = '?' })
	end
end

return M
