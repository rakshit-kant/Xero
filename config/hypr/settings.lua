-- settings.lua
-- Xero Hyprland Core Settings

-----------------------------------------------------------
-- Environment Variables
-----------------------------------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------------------------------------------
-- General Window Behavior
-----------------------------------------------------------

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 18,

		border_size = 2,

		-- Xero Oxocarbon border palette
		col = {
			active_border = {
				colors = {
					"rgba(78a9ffff)",
					"rgba(33ccffff)",
				},
				angle = 45,
			},

			inactive_border = "rgba(393939aa)",
		},

		resize_on_border = true,

		allow_tearing = false,

		layout = "dwindle",
	},

	-----------------------------------------------------------
	-- Dwindle Layout
	-----------------------------------------------------------

	dwindle = {
		pseudotile = true,

		preserve_split = true,

		smart_split = true,
	},

	-----------------------------------------------------------
	-- Master Layout
	-----------------------------------------------------------

	master = {
		new_status = "master",

		mfact = 0.55,
	},

	-----------------------------------------------------------
	-- Scrolling Layout
	-----------------------------------------------------------

	scrolling = {
		fullscreen_on_one_column = true,
	},

	-----------------------------------------------------------
	-- Miscellaneous
	-----------------------------------------------------------

	misc = {
		force_default_wallpaper = -1,

		disable_hyprland_logo = true,

		disable_splash_rendering = true,

		vfr = true,
	},
})
