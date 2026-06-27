vim.schedule(function()
	vim.pack.add({
		'https://github.com/mfussenegger/nvim-dap',
		'https://github.com/igorlfs/nvim-dap-view',
	})

	local function pick_file_sync()
		local co = coroutine.running()
		-- assert(co, 'This function must be run inside a coroutine')

		require('snacks').picker.files({
			cwd = vim.fn.getcwd(),
			actions = {
				confirm = function(picker, item)
					picker:close()
					local selection = item and item.file or nil
					---@diagnostic disable-next-line
					if coroutine.status(co) ~= 'running' then coroutine.resume(co, selection) end
				end,
			},
			exclude = { 'build/CMakeFiles' },
			args = { '--type', 'x', '--exclude', '*vcpkg_installed*' },
		})

		-- Yield execution here. The function "stops" until resume is called above.
		--- @diagnostic disable-next-line: await-in-sync
		return coroutine.yield()
	end

	local dap = require('dap')
	local dap_view = require('dap-view')

	local opts = {
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
	}

	dap_view.setup(opts --[[@as dapview.Config]])

	-- dap.set_log_level('TRACE')

	local bind = vim.keymap.set

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
			command = 'lldb-dap.exe', -- C:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/Llvm/x64/bin/
			name = 'lldb',
		}

		dap.configurations.cpp = {
			{
				name = 'Launch (codelldb)',
				type = 'codelldb',
				request = 'launch',
				program = function() return pick_file_sync() end,
				cwd = '${workspaceFolder}',
				-- preLaunchTask = 'CMake Build',
			},
		}
	else
		dap.adapters.lldb = {
			type = 'executable',
			command = 'lldb-dap',
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
				name = 'Launch (gdb)',
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

	-- vim.schedule(function() require('overseer').enable_dap() end)

	vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
	vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
end)
