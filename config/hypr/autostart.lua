-- autostart.lua
local vars = require("variables")

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
exec-once = waybar
exec-once = swaync
exec-once = awww-daemon
exec-once = ~/.config/hypr/scripts/wallpaper.sh
exec-once = hypridle
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = wl-paste --watch cliphist store
-- Uncomment and modify to use:
-- hl.on("hyprland.start", function () 
--   hl.exec_cmd(vars.terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)
