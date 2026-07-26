local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13.0

config.color_scheme = "Oxocarbon Dark"

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.92
config.text_background_opacity = 0.92

config.window_padding = {
	left = 12,
	right = 12,
	top = 10,
	bottom = 10,
}

config.cursor_blink_rate = 600
config.cursor_style = "BlinkingBar"

config.default_cursor_style = "BlinkingBar"

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
