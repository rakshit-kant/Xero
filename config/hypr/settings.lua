-- settings.lua
-- Xero Hyprland Core Settings

-----------------------------------------------------------
-- Environment Variables
-----------------------------------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------------------------------------------
-- Core Configuration
-----------------------------------------------------------

hl.config({

	-------------------------------------------------------
	-- General
	-------------------------------------------------------

	general = {

		gaps_in = 6,
		gaps_out = 18,

		border_size = 2,

		resize_on_border = true,
		resize_corner = 0,

		allow_tearing = false,

		layout = "dwindle",

		col = {
			active_border = {
				colors = {
					"rgba(78a9ffff)",
					"rgba(33ccffff)",
				},
				angle = 45,
			},

			inactive_border = "rgba(4d4d4daa)",
		},
	},

	-------------------------------------------------------
	-- Cursor
	-------------------------------------------------------

	cursor = {

		no_hardware_cursors = false,
	},

	-------------------------------------------------------
	-- Dwindle
	-------------------------------------------------------

	dwindle = {

		preserve_split = true,

		smart_split = true,

		force_split = 2,
	},

	-------------------------------------------------------
	-- Master
	-------------------------------------------------------

	master = {

		new_status = "master",

		mfact = 0.55,
	},

	-------------------------------------------------------
	-- Scrolling
	-------------------------------------------------------

	scrolling = {

		fullscreen_on_one_column = true,
	},

	-------------------------------------------------------
	-- Input
	-------------------------------------------------------

	input = {

		follow_mouse = 1,

		float_switch_override_focus = 2,
	},

	-------------------------------------------------------
	-- Misc
	-------------------------------------------------------

	misc = {

		force_default_wallpaper = -1,

		disable_hyprland_logo = true,

		disable_splash_rendering = true,

		middle_click_paste = false,
	},
})
