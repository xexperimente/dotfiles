local add_on_event = require('pack').add_on_event
local add_on_filetype = require('pack').add_on_file_type

-- Debugging.
add_on_event('UIEnter', {
	{
		src = 'jbyuki/one-small-step-for-vimkind', -- Lua adapter.
		setup = false,
		on_setup = function()
			vim.keymap.set(
				'n',
				'<leader>dl',
				function() require('osv').launch({ port = 8086 }) end,
				{ desc = 'Launch Lua adapter' }
			)
		end,
	},
})

add_on_filetype('lua', {
	{
		src = 'igorlfs/nvim-dap-view',
		module_name = 'dap-view',
		opts = {
			winbar = {
				sections = { 'scopes', 'breakpoints', 'threads', 'exceptions', 'repl', 'console' },
				default_section = 'scopes',
			},
			windows = { size = 18 },
			-- When jumping through the call stack, try to switch to the buffer if already open in
			-- a window, else use the last window to open the buffer.
			switchbuf = 'usetab,uselast',
		},
	},
	-- Virtual text.
	{
		src = 'theHamsta/nvim-dap-virtual-text',
		opts = { virt_text_pos = 'eol' },
	},
	{
		src = 'mfussenegger/nvim-dap',
		setup = false,
		on_setup = function()
			local bind = vim.keymap.set
			local dap = require('dap')

			bind('n', '<leader>dc', function()
				local cond = vim.fn.input('Breakpoint condition: ')
				dap.set_breakpoint(cond)
			end, { desc = 'Conditional breakpoint' })
			bind('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
			bind('n', '<F5>', dap.continue, { desc = 'Continue' })
			bind('n', '<S-F5>', dap.terminate, { desc = 'Terminate debug session' })
			bind('n', '<C-S-F5>', dap.restart, { desc = 'Restart debug session' })
			bind('n', '<F9>', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
			bind('n', '<F10>', dap.step_over, { desc = 'Step over' })
			bind('n', '<F11>', dap.step_into, { desc = 'Step into' })
			bind('n', '<F12>', dap.step_out, { desc = 'Step out' })

			local dv = require('dap-view')

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

			dv.setup(opts --[[@as dapview.Config]])

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('xexperimente/dap_options', { clear = true }),
				desc = 'Set options for DAP UI',
				pattern = 'dap-view',
				callback = function() vim.wo[0][0].listchars = 'space: ,tab:   ' end,
			})

			-- Automatically open the UI when a new debug session is created.
			dap.listeners.before.attach['dap-view-config'] = function() dv.open() end
			dap.listeners.before.launch['dap-view-config'] = function() dv.open() end
			dap.listeners.before.event_terminated['dap-view-config'] = function() dv.close() end
			dap.listeners.before.event_exited['dap-view-config'] = function() dv.close() end

			-- Lua configurations.
			dap.adapters.nlua = function(callback, config)
				callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
			end
			dap.configurations['lua'] = {
				{
					type = 'nlua',
					request = 'attach',
					name = 'Attach to running Neovim instance',
				},
			}

			-- Custom icons
			local sign = vim.fn.sign_define
			local rarrow = require('icons').arrows.right

			sign('DapBreakpoint', { text = ' ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
			sign('DapStopped', { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
			sign('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
			sign('DapBreakpointRejected', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
			sign('DapLogPoint', { text = rarrow .. ' ' })
		end,
	},
})
-- vim.defer_fn(function()
-- 	vim.pack.add({
-- 		'https://github.com/mfussenegger/nvim-dap',
-- 		'https://github.com/igorlfs/nvim-dap-view',
-- 	})
--
-- 	local function pick_file_sync()
-- 		local co = coroutine.running()
-- 		-- assert(co, 'This function must be run inside a coroutine')
--
-- 		require('snacks').picker.files({
-- 			cwd = vim.fn.getcwd(),
-- 			actions = {
-- 				confirm = function(picker, item)
-- 					picker:close()
-- 					local selection = item and item.file or nil
-- 					---@diagnostic disable-next-line
-- 					if coroutine.status(co) ~= 'running' then coroutine.resume(co, selection) end
-- 				end,
-- 			},
-- 			exclude = { 'build/CMakeFiles' },
-- 			args = { '--type', 'x', '--exclude', '*vcpkg_installed*' },
-- 		})
--
-- 		-- Yield execution here. The function "stops" until resume is called above.
-- 		--- @diagnostic disable-next-line: await-in-sync
-- 		return coroutine.yield()
-- 	end
--
-- 	local dap = require('dap')
-- 	local dap_view = require('dap-view')
--
-- 	local opts = {
-- 		winbar = {
-- 			show = true,
-- 			sections = { 'watches', 'scopes', 'breakpoints', 'threads', 'repl' },
-- 			base_sections = {
-- 				breakpoints = { label = 'Breakpoints', keymap = 'B' },
-- 				scopes = { label = 'Local', keymap = 'S' },
-- 				exceptions = { label = 'Exceptions', keymap = 'E' },
-- 				watches = { label = 'Watch', keymap = 'W' },
-- 				threads = { label = 'Threads', keymap = 'T' },
-- 				repl = { label = 'REPL', keymap = 'R' },
-- 				sessions = { label = 'Sessions', keymap = 'K' },
-- 				console = { label = 'Console', keymap = 'C' },
-- 			},
-- 			controls = {
-- 				enabled = true,
-- 				position = 'left',
-- 				buttons = {
-- 					'play',
-- 					'run_last',
-- 					'terminate',
-- 				},
-- 			},
-- 		},
-- 	}
--
-- 	dap_view.setup(opts --[[@as dapview.Config]])
--
-- 	-- dap.set_log_level('TRACE')
--
-- 	local bind = vim.keymap.set
--
-- 	bind('n', '<F5>', '<cmd>DapContinue<cr>')
-- 	bind('n', '<F9>', '<cmd>DapToggleBreakpoint<cr>')
-- 	bind('n', '<F10>', '<cmd>DapStepOver<cr>')
-- 	bind('n', '<F11>', '<cmd>DapStepInto<cr>')
-- 	bind('n', '<S-F5>', '<cmd>DapTerminate<cr>')
-- 	bind('n', '<C-S-F5>', function() require('dap').restart() end)
--
-- 	dap.listeners.before.attach['dap-view-config'] = function() dap_view.open() end
-- 	dap.listeners.before.launch['dap-view-config'] = function() dap_view.open() end
-- 	dap.listeners.before.event_terminated['dap-view-config'] = function() dap_view.close() end
-- 	dap.listeners.before.event_exited['dap-view-config'] = function() dap_view.close() end
--
-- 	if vim.fn.has('win32') == 1 then
-- 		dap.adapters.codelldb = {
-- 			type = 'server',
-- 			port = '${port}',
-- 			executable = {
-- 				command = 'codelldb.cmd',
-- 				args = { '--port', '${port}' },
-- 				detached = false,
-- 			},
-- 		}
--
-- 		dap.adapters.lldb = {
-- 			type = 'executable',
-- 			command = 'lldb-dap.exe', -- C:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/Llvm/x64/bin/
-- 			name = 'lldb',
-- 		}
--
-- 		dap.configurations.cpp = {
-- 			{
-- 				name = 'Launch (codelldb)',
-- 				type = 'codelldb',
-- 				request = 'launch',
-- 				program = function() return pick_file_sync() end,
-- 				cwd = '${workspaceFolder}',
-- 				-- preLaunchTask = 'CMake Build',
-- 			},
-- 		}
-- 	else
-- 		dap.adapters.lldb = {
-- 			type = 'executable',
-- 			command = 'lldb-dap',
-- 			detached = false,
-- 		}
--
-- 		dap.adapters.gdb = {
-- 			type = 'executable',
-- 			command = 'gdb',
-- 			args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
-- 			detached = false,
-- 		}
--
-- 		dap.configurations.cpp = {
-- 			{
-- 				name = 'Launch (gdb)',
-- 				type = 'gdb',
-- 				request = 'launch',
-- 				program = function() return pick_file_sync() end,
-- 				cwd = '${workspaceFolder}',
-- 				stopAtBeginningOfMainSubprogram = false,
-- 			},
-- 		}
-- 	end
--
-- 	dap.configurations.rust = {
-- 		{
-- 			name = 'Launch',
-- 			type = 'codelldb',
-- 			request = 'launch',
-- 			program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
-- 			cwd = '${workspaceFolder}',
-- 			stopOnEntry = false,
-- 		},
-- 	}
--
-- 	dap.configurations.zig = {
-- 		{
-- 			name = 'Launch',
-- 			type = 'codelldb',
-- 			request = 'launch',
-- 			program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
-- 			cwd = '${workspaceFolder}',
-- 			stopOnEntry = false,
-- 			args = {},
-- 		},
-- 	}
--
-- 	-- vim.schedule(function() require('overseer').enable_dap() end)
--
-- 	vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
-- 	vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
-- 	vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
-- 	vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
-- end, 10)
