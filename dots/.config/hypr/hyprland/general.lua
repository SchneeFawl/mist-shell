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
    sensitivity = 0,
})

-----------------------
--|  LOOK AND FEEL  |--
-----------------------
hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 8,

        border_size      = 2,

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        allow_tearing    = false,

        layout           = "dwindle",

        snap = { enabled = true }
    },

    decoration = {
        rounding = 12,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 0.9,
        inactive_opacity = 0.8,

        blur = {
            enabled           = true,
            new_optimizations = true,
            size              = 6,
            passes            = 2,
            vibrancy          = 0.1696,
            xray              = false,
            special           = false,
        },

        shadow = {
            enabled      = true,
            color        = "rgba(1a1a1aee)",
            range        = 12,
            render_power = 3,
            offset       = {0, 0},
            scale        = 1,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = false
    },

    xwayland = {
      force_zero_scaling = true
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
            scroll_factor = 0.75
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
