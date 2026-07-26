-- settings.lua

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- General settings
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    -- Layout configurations
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },

    -- Misc
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})
