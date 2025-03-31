local Plugin = { 'rcarriga/nvim-dap-ui' }

Plugin.dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }

Plugin.cmds = {
	'DapToggleBreakpoint',
	'DapContinue',
	'DapStepInto',
	'DapStepOver',
}

Plugin.keys = {
	'<f5>',
	'<f9>',
	'<f10>',
	'<f11>',
}

-- TODO: 'theHamsta/nvim-dap-virtual-text'

function Plugin.config(_, _)
	local dap = require('dap')
	local dapui = require('dapui')

	dapui.setup({
		controls = { enabled = false },
		layouts = {
			-- {
			-- 	elements = {
			-- 		{
			-- 			id = 'scopes',
			-- 			size = '0.60',
			-- 		},
			-- 		{
			-- 			id = 'console',
			-- 			size = '0.30',
			-- 		},
			-- 		{
			-- 			id = 'watches',
			-- 			size = '0.10',
			-- 		},
			-- 	},
			-- 	position = 'bottom',
			-- 	size = 10,
			-- },
			{
				elements = {
					'scopes',
				},
				size = 0.3,
				position = 'right',
			},
			{
				elements = {
					'console',
					'breakpoints',
				},
				size = 0.3,
				position = 'bottom',
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = 'single',
			mappings = {
				close = { 'q', '<Esc>' },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil,
		},
	})

	dap.listeners.before.attach.dapui_config = function() dapui.open() end
	dap.listeners.before.launch.dapui_config = function() dapui.open() end
	dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
	dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

	-- dap.set_log_level('trace') -- for log output

	dap.adapters.codelldb = {
		type = 'server',
		port = '${port}',
		executable = {
			command = 'codelldb.cmd',
			args = { '--port', '${port}' },
			detached = false,
		},
	}

	dap.adapters.nlua = function(callback, conf)
		local adapter = {
			type = 'server',
			host = conf.host or '127.0.0.1',
			port = conf.port or 8086,
		}
		if conf.start_neovim then
			local dap_run = dap.run
			dap.run = function(c)
				adapter.port = c.port
				adapter.host = c.host
			end
			require('osv').run_this()
			dap.run = dap_run
		end
		callback(adapter)
	end

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
	dap.configurations.lua = {
		{
			type = 'nlua',
			request = 'attach',
			name = 'Run this file',
			start_neovim = {},
		},
		{
			type = 'nlua',
			request = 'attach',
			name = 'Attach to running Neovim instance (port = 8086)',
			port = 8086,
		},
	}
	vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
	vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
	vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
	-- local sign = vim.fn.sign_define
	--
	-- sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	-- sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	-- sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
	-- sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

	local bind = vim.keymap.set

	bind('n', '<F1>', function() require('dap.ui.widgets').hover(nil, {}) end, { desc = 'Dap hover' })
	bind('n', '<F5>', ':DapContinue<cr>', { desc = 'Continue debugging' })
	bind('n', '<F9>', ':DapToggleBreakpoint<cr>', { desc = 'Toggle breakpoint' })
	bind('n', '<F10>', ':DapStepOver<cr>', { desc = 'Step over' })
	bind('n', '<F11>', ':DapStepInto<cr>', { desc = 'Step into' })
end

return Plugin
