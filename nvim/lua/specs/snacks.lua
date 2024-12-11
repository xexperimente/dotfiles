local Plugin = { 'folke/snacks.nvim' }

Plugin.priority = 1000

Plugin.lazy = false

Plugin.opts = {
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ key = 'n', desc = 'New File', action = ':ene | startinsert' },
				{ key = 'r', desc = 'Recent Files', action = ':Pick oldfiles' },
				{ key = 'f', desc = 'Find File', action = ':Pick files' },
				{
					key = 'c',
					desc = 'Config',
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				-- {
				-- 	key = 'L',
				-- 	desc = 'Lazy',
				-- 	action = ':Lazy',
				-- 	enabled = package.loaded.lazy ~= nil,
				-- },
				{ key = 'q', desc = 'Quit', action = ':qa' },
			},
		},
		sections = {
			{
				section = 'terminal',
				cmd = 'chafa c:/Users/xexpe/Pictures/rats2.png --format symbols --symbols vhalf --size 60x60 --bg=faf4ed --colors=full; sleep .1',
				height = 32,
				padding = 1,
			},
			{
				-- pane = 2,
				{ section = 'keys', gap = 1, padding = 1 },
				{ section = 'startup' },
			},
		},
	},
	indent = { enabled = false },
	input = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
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
				file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
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
