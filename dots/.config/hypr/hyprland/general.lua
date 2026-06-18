-- MONITOR CONFIG
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 3,
    direction = "pinch",
    action = "fullscreen"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-----------------------
--|  LOOK AND FEEL  |--
-----------------------
hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 6,

        border_size      = 2,

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        allow_tearing    = false,

        layout           = "dwindle",
    },

    decoration = {
        rounding = 12,
        rounding_power = 3,

        -- Change transparency of focused and unfocused windows
        active_opacity = 0.9,
        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled           = true,
            new_optimizations = true,
            size              = 6,
            passes            = 2,
            vibrancy          = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = false
    }
})

-- INPUT CONFIG
hl.config({
    input = {
        kb_layout          = "us",
        numlock_by_default = true,

        follow_mouse       = 1,
        force_no_accel     = false,
        sensitivity        = 0,
        -- accel_profile = "flat",

        touchpad           = {
            natural_scroll = true,
        },
    },
})

-- useless
hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
