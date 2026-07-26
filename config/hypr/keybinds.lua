-- keybinds.lua
-- Xero Hyprland Keybindings

local variables = require("variables")
local mainMod = variables.mainMod

-----------------------------------------------------------
-- Applications
-----------------------------------------------------------

-- Terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(variables.terminal))

-- File Manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(variables.fileManager))

-- Browser
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(variables.browser))

-- Launcher
hl.bind(mainMod, hl.dsp.exec_cmd(variables.menu))

-- Close Window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Fullscreen Toggle
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)

-- Floating Toggle
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.float({
		action = "toggle",
	})
)

-- Pseudo Tiling
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Split Toggle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- Clipboard History
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | walker --dmenu | cliphist decode | wl-copy"))
-----------------------------------------------------------
-- System
-----------------------------------------------------------

-- Exit Hyprland
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)

-- Reload Config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-----------------------------------------------------------
-- System Utilities
-----------------------------------------------------------

-- Lock Screen
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Notification Center
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))

-- Toggle Window Opacity
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-opacity.sh"))

-----------------------------------------------------------
-- Window Focus
-----------------------------------------------------------

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-----------------------------------------------------------
-- Move Windows
-----------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))

hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-----------------------------------------------------------
-- Workspaces
-----------------------------------------------------------

for i = 1, 10 do
	local key = i % 10

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-----------------------------------------------------------
-- Special Workspace
-----------------------------------------------------------

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({
		workspace = "special:magic",
	})
)

-----------------------------------------------------------
-- Mouse
-----------------------------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-----------------------------------------------------------
-- Workspace Scrolling
-----------------------------------------------------------

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-----------------------------------------------------------
-- Multimedia
-----------------------------------------------------------

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-----------------------------------------------------------
-- Brightness
-----------------------------------------------------------

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-----------------------------------------------------------
-- Media
-----------------------------------------------------------

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
