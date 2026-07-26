-- decoration.lua
-- Xero Hyprland Decoration Profile

hl.config({
	decoration = {
		-- Window corners
		rounding = 14,
		rounding_power = 3,

		-- Window transparency
		active_opacity = 0.96,
		inactive_opacity = 0.88,

		-- Shadow system
		shadow = {
			enabled = true,

			range = 12,
			render_power = 4,

			color = 0xee000000,

			offset = "0 4",
			scale = 1.0,
		},

		-- Blur system
		blur = {
			enabled = true,

			size = 8,
			passes = 3,

			ignore_opacity = true,
			new_optimizations = true,

			noise = 0.0117,
			contrast = 1.05,
			brightness = 0.95,

			vibrancy = 0.25,
			vibrancy_darkness = 0.1,
		},

		-- Dim inactive windows slightly
		dim_inactive = true,
		dim_strength = 0.08,
	},
})
