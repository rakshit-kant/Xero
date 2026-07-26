local wezterm = require("wezterm")

local config = wezterm.config_builder()

-----------------------------------------------------------
-- Font
-----------------------------------------------------------

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
})

config.font_size = 13.5

config.line_height = 1.1

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------

config.color_scheme = "Oxocarbon Dark"

-- Liquid glass effect
config.window_background_opacity = 0.82
config.text_background_opacity = 0.82

config.window_background_gradient = {
	colors = {
		"#161616",
		"#1c1c1c",
	},
}

config.window_decorations = "RESIZE"

-----------------------------------------------------------
-- Window
-----------------------------------------------------------

config.window_padding = {
	left = 14,
	right = 14,
	top = 12,
	bottom = 12,
}

config.window_close_confirmation = "NeverPrompt"

-----------------------------------------------------------
-- Cursor
-----------------------------------------------------------

config.default_cursor_style = "BlinkingBar"

config.cursor_blink_rate = 600

-----------------------------------------------------------
-- Tabs
-----------------------------------------------------------

config.enable_tab_bar = false

config.hide_tab_bar_if_only_one_tab = true

-----------------------------------------------------------
-- Performance
-----------------------------------------------------------

config.front_end = "WebGpu"

config.max_fps = 120

-----------------------------------------------------------
-- Keybinds
-----------------------------------------------------------

config.keys = {

	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},

	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},

	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

return config
