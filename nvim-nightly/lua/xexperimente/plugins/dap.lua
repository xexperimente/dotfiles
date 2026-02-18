vim.pack.add({
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/igorlfs/nvim-dap-view',
})

local function pick_file_sync()
	local co = coroutine.running()
	-- assert(co, 'This function must be run inside a coroutine')

	local filter = vim.fn.has('win32') and '*.exe' or ''

	require('snacks').picker.files({
		cwd = vim.fn.getcwd(),
		actions = {
			confirm = function(picker, item)
				picker:close()
				local selection = item and item.file or nil
				-- Resume the coroutine and pass the file back
				coroutine.resume(co, selection)
			end,
		},
		exclude = { 'build/CMakeFiles' },
		args = vim.fn.has('win32') == 1 and { '--glob', filter } or {},
	})

	-- Yield execution here. The function "stops" until resume is called above.
	--- @diagnostic disable-next-line: await-in-sync
	return coroutine.yield()
end

vim.defer_fn(function()
	local bind = vim.keymap.set
	local dap = require('dap')
	local dap_view = require('dap-view')

	dap_view.setup({
		winbar = {
			show = true,
			sections = { 'watches', 'scopes', 'breakpoints', 'threads', 'repl' },
			base_sections = {
				breakpoints = { label = 'Breakpoints', keymap = 'B' },
				scopes = { label = 'Local', keymap = 'S' },
				exceptions = { label = 'Exceptions', keymap = 'E' },
				watches = { label = 'Watch', keymap = 'W' },
				threads = { label = 'Threads', keymap = 'T' },
				repl = { label = 'REPL', keymap = 'R' },
				sessions = { label = 'Sessions', keymap = 'K' },
				console = { label = 'Console', keymap = 'C' },
			},
			controls = {
				enabled = true,
				position = 'left',
				buttons = {
					'play',
					'run_last',
					'terminate',
				},
			},
		},
	})

	require('overseer').enable_dap()

	-- dap.set_log_level('TRACE')

	bind('n', '<F5>', '<cmd>DapContinue<cr>')
	bind('n', '<F9>', '<cmd>DapToggleBreakpoint<cr>')
	bind('n', '<F10>', '<cmd>DapStepOver<cr>')
	bind('n', '<F11>', '<cmd>DapStepInto<cr>')
	bind('n', '<S-F5>', '<cmd>DapTerminate<cr>')
	bind('n', '<C-S-F5>', function() require('dap').restart() end)

	dap.listeners.before.attach['dap-view-config'] = function() dap_view.open() end
	dap.listeners.before.launch['dap-view-config'] = function() dap_view.open() end
	dap.listeners.before.event_terminated['dap-view-config'] = function() dap_view.close() end
	dap.listeners.before.event_exited['dap-view-config'] = function() dap_view.close() end

	if vim.fn.has('win32') == 1 then
		dap.adapters.codelldb = {
			type = 'server',
			port = '${port}',
			executable = {
				command = 'codelldb.cmd',
				args = { '--port', '${port}' },
				detached = false,
			},
		}

		dap.adapters.lldb = {
			type = 'executable',
			command = 'C:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/Llvm/x64/bin/lldb-dap.exe',
			name = 'lldb',
		}

		dap.configurations.cpp = {
			{
				name = 'Launch (CodeLLDB)',
				type = 'codelldb',
				request = 'launch',
				program = function() return pick_file_sync() end,
				cwd = '${workspaceFolder}',
				preLaunchTask = 'CMake Build',
			},
		}
	else
		dap.adapters.codelldb = {
			type = 'executable',
			command = 'codelldb',
			detached = false,
		}

		dap.adapters.gdb = {
			type = 'executable',
			command = 'gdb',
			args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
			detached = false,
		}

		dap.configurations.cpp = {
			{
				name = 'Launch (System GDB)',
				type = 'gdb',
				request = 'launch',
				program = function() return pick_file_sync() end,
				cwd = '${workspaceFolder}',
				stopAtBeginningOfMainSubprogram = false,
			},
		}
	end

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
end, 400)
