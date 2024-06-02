local Plugin = { 'sontungexpt/sttusline' }

Plugin.cond = true

Plugin.branch = 'table_version'

Plugin.dependencies = { 'nvim-tree/nvim-web-devicons' }

Plugin.event = 'BufEnter'

local colors = {}

function colors.text()
	local ok, palette = pcall(require, 'rose-pine.palette')
	local fg = ok and palette.text or '#555555'

	return fg
end

function colors.base()
	local ok, palette = pcall(require, 'rose-pine.palette')
	local fg = ok and palette.base or '#f4faed'

	return fg
end

Plugin.opts = {
	components = {
		{
			'mode',
			{
				configs = {
					mode_colors = {
						['STTUSLINE_NORMAL_MODE'] = { fg = colors.base(), bg = '#5FB0FC' },
						['STTUSLINE_INSERT_MODE'] = { fg = colors.base(), bg = '#98bb6c' },
						['STTUSLINE_REPLACE_MODE'] = { fg = colors.base(), bg = '#e46846' },
						['STTUSLINE_VISUAL_MODE'] = { fg = colors.base(), bg = '#ffa066' },
						['STTUSLINE_TERMINAL_MODE'] = { fg = colors.base(), bg = '#e6c384' },
					},
				},
			},
		},
		{
			'filename',
			{
				colors = { fg = colors.text() },
				update = function(_)
					local buf_modified = vim.api.nvim_get_option_value('modified', {})
					local filename = vim.fn.expand('%:t')
					if filename == '' then filename = '' end
					return filename .. (buf_modified and '*' or '')
				end,
			},
		},
		{
			'git-branch',
			{
				configs = {
					icon = '',
				},
			},
		},
		'git-diff',
		{
			name = 'LspProgress',
			update_group = 'group_name',
			event = { 'LspProgress' }, -- The component will be update when the event is triggered
			user_event = { 'VeryLazy' },
			-- timing = true, -- The component will be update every time interval
			lazy = true,
			space = nil,
			configs = {},
			padding = 1, -- { left = 1, right = 1 }
			colors = {}, -- { fg = colors.black, bg = colors.white }
			separator = nil,
			init = function(_, _) end,
			update = function(_, _)
				local lsp = vim.lsp.status()

				if string.len(lsp) > 0 then
					local parts = vim.split(lsp, ',')

					if #parts > 0 then
						local function stl_escape(str)
							if type(str) ~= 'string' then return str end
							return str:gsub('%%', '%%%%')
						end

						return 'LSP ' .. stl_escape(parts[#parts])
					end
				end
				return ''
			end,
			condition = function(_, _) return false end,
			on_highlight = function(_, _) end,
		},
		'%=',
		'diagnostics',
		{
			'lsps-formatters',
			{
				update = function(_)
					local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
					local server_names = {}
					-- local has_null_ls = false
					local ignore_lsp_servers = {
						['null-ls'] = true,
						['copilot'] = true,
					}

					for _, client in pairs(buf_clients) do
						local client_name = client.name
						if not ignore_lsp_servers[client_name] then table.insert(server_names, client_name) end
					end

					if package.loaded['conform'] then
						local has_conform, conform = pcall(require, 'conform')
						if has_conform then
							vim.list_extend(
								server_names,
								vim.tbl_map(
									function(formatter) return formatter.name end,
									conform.list_formatters(0)
								)
							)
						end
					end

					return #server_names > 0 and table.concat(server_names, ', ') or 'NO LSP, NO FORMAT '
				end,
			},
		},
		{
			name = 'Lazy',
			update_group = 'group_name',
			event = {}, -- The component will be update when the event is triggered
			user_event = { 'VeryLazy' },
			timing = true, -- The component will be update every time interval
			lazy = true,
			space = nil,
			configs = {},
			padding = 1, -- { left = 1, right = 1 }
			colors = {}, -- { fg = colors.black, bg = colors.white }
			separator = nil,
			init = function(_, _) end,
			update = function(_, _)
				local status = require('lazy.status')
				local text = '%#IncSearch# ' .. (status.has_updates() and status.updates() or '') .. ' %*'

				return status.has_updates() and text or ''
			end,
			condition = function(_, _) return require('lazy.status').has_updates() end,
			on_highlight = function(_, _) end,
		},
		-- {
		-- 	'indent',
		-- 	{
		-- 		colors = { fg = colors.text() },
		-- 	},
		-- },
		-- 'encoding',
		{
			'pos-cursor',
			{
				colors = { fg = colors.text() },
			},
		},
		'pos-cursor-progress',
	},
}

return Plugin
