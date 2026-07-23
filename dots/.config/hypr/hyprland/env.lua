-----------------------------
--| ENVIRONMENT VARIABLES |--
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- TOOLKIT BACKEND
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_SCALE_FACTOR_ROUNDING_POLICY", "PassThrough")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- iGPU shit
hl.env("LIBVA_DRIVER_NAME", "iHD")
