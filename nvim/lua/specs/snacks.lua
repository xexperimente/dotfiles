local Plugin = { 'folke/snacks.nvim' }

Plugin.priority = 1000

Plugin.lazy = false

Plugin.opts = {
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
				{ icon = ' ', key = 'r', desc = 'Recent Files', action = ':Pick oldfiles' },
				{ icon = ' ', key = 'f', desc = 'Find File', action = ':Pick files' },
				{ icon = ' ', key = 'l', desc = 'Git log', action = ':Pick git_commits' },
				{ icon = ' ', key = 'c', desc = 'Git changes', action = ':Pick git_files' },
				{
					key = 'x',
					icon = ' ',
					desc = 'Config',
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
			},
			header = [[
█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
█ █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █▀▀▀▀▀▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀▀▀▀▀█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀█ █
█ █ ▀█ █▀ █▀▀▀▀ ▀█ █▀ █ █▀▀█ █▀▀▀▀ █▀▀▀█ █▀▀▀▀█ █▀█ █▀█ █▀▀▀▀ █▀█ █▀█ █▀▀▀▀▀█ █▀▀▀▀ █ █
█ █▄▄▄▄▄▄▄█ ▀▀▀█▄▄▄▄▄▄█ ▄▄▄█ █ ▀▀▀ █ █▄█ ▀▀ █▀▀ █  ▀  █ █ ▀▀▀ █ ▀█▄ █ ▀▀  █▀▀ █ ▀▀▀▀█ █
█ █  ▄ ▄  █ ▀▀▀▀ ▄ ▄  █ █ ▄▄ █ ▀▀▀ █ ▄ █▄█▀ ▀ ▄ █ █▄█ █ █ ▀▀▀ █ ▄ ▀ █ █▀█ █ █ █ ▀▀▀▀█ █
█ █ ▀▀ ▀▀ ▀▀▀▀▀ ▀▀ ▀▀ ▀▀▀ █  ▀▀▀▀▀ ▀▀▀ █ ▀▀▀▀▀▀ █ █ ▀ ▀ ▀▀▀▀█ ▀▀▀ ▀▀█ █ ▀▀▀ █ ▀▀▀▀▀ █ █
█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀█▀▀▀ █▀▀▀▀▀█▀ ▀▀▀▀▀▀▀▀█▀▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █▀▀▀▀▀▀ █
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█ ▀▀▀▀█▀▀▀▀▀▀▀▀▀▀█▀▀▀▀▀▀▀▀▀▀▀▀ █ █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
                            █ █ █▀▀▀█ █▀▀▀█ █▀▀▀▄█▀▀▀▀ █▀▀▀█ █ █                       
                            █ █ █ █▄█▄█ █ █ █ █▄ █ ▀▀▀ █ ▀▀█ █ █                       
                            █ █ █ ▀ █ █ ▀ █ █ ▀ ▄█ ▀▀▀ ▀▀▀ █ █ █                       
                            █ █ █▀▀▀▀ ▀▀▀▀█ ▀▀▀▀▀ ▀▀▀█ █▀▀▀█ █ █                       
                            █ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █ █                       
                            ▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀                       
]],
		},
		formats = {
			header = { '%s', align = 'center', hl = 'ErrorMsg' },
		},
		sections = {
			{ section = 'header' },
			{
				icon = '★',
				section = 'keys',
				title = 'Keys',
				indent = 3,
				gap = 0,
				padding = 1,
			},
			{
				icon = '',
				section = 'recent_files',
				title = 'Recent files:',
				indent = 3,
				padding = 1,
			},
			{
				icon = '',
				section = 'projects',
				title = 'Projects:',
				indent = 3,
				padding = 1,
			},
			{ section = 'startup' },
		},
	},
	indent = { enabled = false },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	statuscolumn = {
		left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
		right = { 'fold', 'git' }, -- priority of signs on the right (high to low
		folds = {
			open = true, -- show open fold icons
			git_hl = true, -- use Git Signs hl for fold icons
		},
		git = {
			-- patterns to match Git signs
			patterns = { 'GitSign', 'MiniDiffSign' },
		},
		refresh = 50, -- refresh at most every 50ms
	},
	scroll = { enable = true },
}

Plugin.keys = {
	{ '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
	{ '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
	{ '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
	{ '<leader>gB', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
	{ '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
	{ '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
	{
		'<leader>N',
		desc = 'Neovim News',
		function()
			Snacks.win({
				file = vim.api.nvim_get_runtime_file('doc/news.txt', true)[1],
				width = 0.6,
				height = 0.6,
				border = 'single',
				wo = {
					spell = false,
					wrap = false,
					signcolumn = 'yes',
					statuscolumn = ' ',
					conceallevel = 3,
				},
			})
		end,
	},
	{
		'<leader>o',
		desc = 'Messages history',
		function()
			local lines = {}
			for s in vim.fn.execute('messages'):gmatch('[^\n]+') do
				table.insert(lines, s)
			end

			Snacks.win({
				text = lines,
				width = 0.6,
				height = 0.6,
				border = 'single',
				wo = {
					spell = false,
					wrap = false,
					signcolumn = 'yes',
					statuscolumn = ' ',
					conceallevel = 3,
				},
			})
		end,
	},
}

Plugin.init = function()
	vim.api.nvim_create_autocmd('User', {
		pattern = 'VeryLazy',
		callback = function()
			-- Setup some globals for debugging (lazy-loaded)
			_G.dd = function(...) Snacks.debug.inspect(...) end
			_G.bt = function() Snacks.debug.backtrace() end
			vim.print = _G.dd -- Override print to use snacks for `:=` command

			-- Create some toggle mappings
			Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
			Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
			Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
			-- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
			Snacks.toggle
				.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
				:map('<leader>uc')
			Snacks.toggle.diagnostics():map('<leader>ud')
			Snacks.toggle.line_number():map('<leader>ul')
			Snacks.toggle.inlay_hints():map('<leader>uh')
			Snacks.toggle.dim():map('<leader>uD')
			Snacks.toggle.treesitter():map('<leader>uT')
			Snacks.toggle.indent():map('<leader>ug')
		end,
	})
	vim.api.nvim_create_autocmd('User', {
		pattern = 'SnacksDashboardOpened',
		callback = function(data) vim.b[data.buf].miniindentscope_disable = true end,
	})

	---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
	local progress = vim.defaulttable()
	vim.api.nvim_create_autocmd('LspProgress', {
		---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
			if not client or type(value) ~= 'table' then return end
			local p = progress[client.id]

			for i = 1, #p + 1 do
				if i == #p + 1 or p[i].token == ev.data.params.token then
					p[i] = {
						token = ev.data.params.token,
						msg = ('[%3d%%] %s%s'):format(
							value.kind == 'end' and 100 or value.percentage or 100,
							value.title or '',
							value.message and (' **%s**'):format(value.message) or ''
						),
						done = value.kind == 'end',
					}
					break
				end
			end

			local msg = {} ---@type string[]
			progress[client.id] = vim.tbl_filter(
				function(v) return table.insert(msg, v.msg) or not v.done end,
				p
			)

			local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
			vim.notify(table.concat(msg, '\n'), 'info', {
				id = 'lsp_progress',
				title = client.name,
				opts = function(notif)
					notif.icon = #progress[client.id] == 0 and ' '
						or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
				end,
			})
		end,
	})
end

return Plugin
