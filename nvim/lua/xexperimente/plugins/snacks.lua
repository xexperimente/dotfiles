local Plugin = { "folke/snacks.nvim" }

Plugin.lazy = false

Plugin.priority = 1000

Plugin.opts = {
	input = { enabled = true },
	bigfile = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enable = true },
	statuscolumn = {
		left = { 'mark', 'sign' },
		right = { 'fold', 'git' },
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
	terminal = {
		win = {
			position = 'float',
			border = "single",
			keys = {
				term_hide = { '<c-t>', function(self) self:hide() end, mode = 't', expr = true },
			},
			wo = {
				winbar = '',
				statusline = '',
			},
		},
		interactive = true,
	},
}

Plugin.keys = {
	{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer"},
	{ '<C-t>', function() Snacks.terminal.toggle(nil, {}) end, desc = 'Toggle terminal' },
	{ '<leader>t', function() Snacks.terminal.toggle(nil, { win = { position = 'float' } }) end, desc = 'Toggle terminal' },
	{ '<leader>T', function() Snacks.terminal.toggle(nil, { win = { position = 'right' } }) end, desc = 'Split terminal' },
	{ '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
	{ '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
	{ '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
	{ '<leader>.', function() Snacks.scratch({ icon = '' }) end, desc = 'Toggle Scratch Buffer' },
	{ '<leader>;', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
	{ '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Open buffers' },
	{ '<leader>ff', function() Snacks.picker.files() end, desc = 'Find files' },
	{ '<leader>fo', function() Snacks.picker.recent() end, desc = 'Recent files' },
	{ '<leader>fg', function() Snacks.picker.grep() end, desc = 'Live grep' },
	{ '<leader>fG', function() Snacks.picker.grep_word() end, desc = 'Grep word' },
	{ '<leader>fc', function() Snacks.picker.highlights() end, desc = 'Find colors' },
	{ '<leader>fh', function() Snacks.picker.help() end, desc = 'Find in help' },
	{ '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'Keymap' },
	{ '<leader>fr', function() Snacks.picker.resume() end, desc = 'Resume last search' },
	{ '<leader>fm', function() Snacks.picker.marks() end, desc = 'Show marks' },
	{ '<leader>fi', function() Snacks.picker.icons() end, desc = 'Find icons' },
	{ '<leader>fH', function() Snacks.picker.command_history() end, desc = 'History' },
	{ '<leader>fu', function() Snacks.picker.undo() end, desc = 'Undo' },
	{ '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git commits' },
	{ '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git branches' },
	{ '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git status' },
	{ '<leader>gB', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
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
				width = 0.8,
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
			Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
			Snacks.toggle.diagnostics():map('<leader>ud')
			Snacks.toggle.line_number():map('<leader>ul')
			Snacks.toggle.inlay_hints():map('<leader>uh')
			Snacks.toggle.dim():map('<leader>uD')
			Snacks.toggle.treesitter():map('<leader>uT')
			Snacks.toggle.indent():map('<leader>ug')
			-- Toggle the profiler
			Snacks.toggle.profiler():map('<leader>pP')
			-- Toggle the profiler highlights
			Snacks.toggle.profiler_highlights():map('<leader>ph')
		end,
	})

	-- vim.api.nvim_create_autocmd('User', {
	-- 	pattern = 'SnacksDashboardOpened',
	-- 	callback = function(data)
	-- 		vim.b[data.buf].miniindentscope_disable = true
	-- 		vim.b[data.buf].ministatusline_disable = true
	-- 	end,
	-- })

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
			progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

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

