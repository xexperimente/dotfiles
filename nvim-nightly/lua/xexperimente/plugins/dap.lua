vim.pack.add({
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/igorlfs/nvim-dap-view',
})

local function pick_file_sync()
	local co = coroutine.running()
	-- assert(co, 'This function must be run inside a coroutine')

	local filter = jit.os:find('Windows') and '*.exe' or ''

	require('snacks').picker.files({
		cwd = vim.fn.getcwd() .. '/',
		actions = {
			confirm = function(picker, item)
				picker:close()
				local selection = item and item.file or nil
				-- Resume the coroutine and pass the file back
				coroutine.resume(co, selection)
			end,
		},
		args = { '--glob', filter },
	})

	-- Yield execution here. The function "stops" until resume is called above.
	--- @diagnostic disable-next-line: await-in-sync
	return coroutine.yield()
end

vim.defer_fn(function()
	local bind = vim.keymap.set
	local dap = require('dap')
	local dap_view = require('dap-view')

	bind('n', '<F5>', '<cmd>DapContinue<cr>')
	bind('n', '<F9>', '<cmd>DapToggleBreakpoint<cr>')
	bind('n', '<F10>', '<cmd>DapStepOver<cr>')
	bind('n', '<F11>', '<cmd>DapStepInto<cr>')

	dap.listeners.before.attach['dap-view-config'] = function() dap_view.open() end
	dap.listeners.before.launch['dap-view-config'] = function() dap_view.open() end
	dap.listeners.before.event_terminated['dap-view-config'] = function() dap_view.close() end
	dap.listeners.before.event_exited['dap-view-config'] = function() dap_view.close() end

	dap.adapters.codelldb = {
		type = 'server',
		port = '${port}',
		executable = {
			command = 'codelldb.cmd',
			args = { '--port', '${port}' },
			detached = false,
		},
	}

	dap.configurations.cpp = {
		{
			name = 'Launch file',
			type = 'codelldb',
			request = 'launch',
			program = function()
				-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				return pick_file_sync()
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}

	dap.configurations.rust = {
		{
			name = 'Launch',
			type = 'codelldb',
			request = 'launch',
			program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}

	dap.configurations.zig = {
		{
			name = 'Launch',
			type = 'codelldb',
			request = 'launch',
			program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
		},
	}

	vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
	vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
end, 600)
