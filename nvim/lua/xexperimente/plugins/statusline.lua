local Plugin = { 'sontungexpt/sttusline' }

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
		'git-branch',
		'git-diff',
		'%=',
		'lsps-formatters',
		{
			'indent',

			{
				colors = { fg = colors.text() },
			},
		},
		-- 'encoding',
		{
			name = 'Lazy',
			update_group = 'group_name',
			event = {}, -- The component will be update when the event is triggered
			user_event = { 'VeryLazy' },
			timing = false, -- The component will be update every time interval
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
			condition = function(_, _) return true end,
			on_highlight = function(_, _) end,
		},
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

-- function Plugin.opts()
-- 	local Component = require('sttusline.component')
-- 	local Lazy = user.create_lazy_component(Component)
-- 	local Filename = user.create_filename_component(Component)
--
-- 	return {
-- 		laststatus = 3,
-- 		disabled = {
-- 			filetypes = {
-- 				-- 'NvimTree',
-- 				-- 'lazy',
-- 			},
-- 			buftypes = {
-- 				-- 'terminal',
-- 			},
-- 		},
-- 		components = {
-- 			'mode',
-- 			Filename,
-- 			'git-diff',
-- 			'%=',
-- 			'diagnostics',
-- 			'lsps-formatters',
-- 			-- 'copilot',
-- 			-- 'indent',
-- 			-- 'encoding',
-- 			Lazy,
-- 			'pos-cursor',
-- 			'pos-cursor-progress',
-- 		},
-- 	}
-- end
--
-- function Plugin.config(_, opts)
-- 	user.update_colors()
--
-- 	require('sttusline').setup(opts)
-- end
--
-- function user.create_filename_component(component)
-- 	local Filename = component.new()
--
-- 	Filename.set_config({
-- 		style = 'default',
-- 	})
--
-- 	Filename.set_timing(true)
--
-- 	Filename.set_update(function()
-- 		local buf_modified = vim.api.nvim_get_option_value('modified', {})
-- 		local filename = vim.fn.expand('%:t')
-- 		if filename == '' then filename = '' end
-- 		return filename .. (buf_modified and '*' or '')
-- 	end)
--
-- 	return Filename
-- end
--
-- function user.create_lazy_component(component)
-- 	local Lazy = component.new()
--
-- 	Lazy.set_config({
-- 		style = 'default',
-- 	})
--
-- 	Lazy.set_timing(true)
-- 	Lazy.set_padding(0)
--
-- 	Lazy.set_update(function()
-- 		local status = require('lazy.status')
-- 		local text = '%#IncSearch# ' .. (status.has_updates() and status.updates() or '') .. ' %*'
--
-- 		return status.has_updates() and text or ''
-- 	end)
--
-- 	return Lazy
-- end
--
-- function user.update_colors()
-- 	local mode = require('sttusline.components.mode')
--
-- 	local ok, palette = pcall(require, 'rose-pine.palette')
-- 	local fg = ok and palette.base or '#f4faed'
--
-- 	mode.set_config({
-- 		mode_colors = {
-- 			['STTUSLINE_NORMAL_MODE'] = { fg = fg, bg = '#5FB0FC' },
-- 			['STTUSLINE_INSERT_MODE'] = { fg = fg, bg = '#98bb6c' },
-- 			['STTUSLINE_REPLACE_MODE'] = { fg = fg, bg = '#e46846' },
-- 			['STTUSLINE_VISUAL_MODE'] = { fg = fg, bg = '#ffa066' },
-- 			['STTUSLINE_TERMINAL_MODE'] = { fg = fg, bg = '#e6c384' },
-- 		},
-- 	})
-- 	mode.set_padding(1)
-- end
--
-- return Plugin
