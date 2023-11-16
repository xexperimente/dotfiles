-- Pull in the wezterm API
local wezterm = require('wezterm')
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then config = wezterm.config_builder() end

-- This is where you actually apply your config choices
local colors = require('lua/rose-pine-dawn').colors()
local window_frame = require('lua/rose-pine-dawn').window_frame()

config.colors = colors
config.window_frame = window_frame

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.win32_system_backdrop = 'Auto' --'Acrylic'
config.window_background_opacity = 0.95

config.font = wezterm.font('Delugia')
config.font_size = 13

config.initial_rows = 50
config.initial_cols = 165

config.default_prog = { 'pwsh' }
config.window_decorations = 'RESIZE'

config.window_padding = {
	bottom = '0',
}

-- Windows default paste from clipboard
config.keys = {
	{ key = 'v', mods = 'CTRL', action = act.PasteFrom('Clipboard') },
}

-- Copy on select
config.mouse_bindings = {
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks, and that it populates
	-- the Clipboard rather the PrimarySelection which is part
	-- of the default assignment for a left mouse click.
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'NONE',
		action = act.CompleteSelection('ClipboardAndPrimarySelection'),
	},
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.CompleteSelectionOrOpenLinkAtMouseCursor('ClipboardAndPrimarySelection'),
	},
	{
		event = { Up = { streak = 1, button = 'Right' } },
		mods = 'NONE',
		action = act({ PasteFrom = 'Clipboard' }),
	},
}

wezterm.on('window-config-reloaded', function(window, _)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	if appearance:find('Dark') then
		overrides.colors = require('lua/rose-pine-moon').colors()
		overrides.window_frame = require('lua/rose-pine-moon').window_frame()
	elseif appearance:find('Light') then
		overrides.colors = require('lua/rose-pine-dawn').colors()
		overrides.window_frame = require('lua/rose-pine-dawn').window_frame()
	end
	window:set_config_overrides(overrides)
end)

-- and finally, return the configuration to wezterm
return config
