------------------------
--|   WINDOW RULES   |--
------------------------

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- disabling blur for xwayland context menus
hl.window_rule({
    match = { class = "^()$", title = "^()$"},
    no_blur = true
})

hl.window_rule({
    match = { title = "^(Open Folder)(.*)$" },
    float = true,
    center = true,
    border_size = 3
})

hl.window_rule({
    match = { title = "^(Open File)(.*)$" },
    float = true,
    center = true,
    border_size = 3,
})

hl.window_rule({
    match = { title = "^(Select a File)(.*)$" },
    float = true,
    center = true,
    border_size = 3
})

hl.window_rule({
    match = { title = "^(Save As)(.*)$" },
    float = true,
    center = true,
    border_size = 3
})

hl.window_rule({
    match = { title = "^(File Upload)(.*)$" },
    float = true,
    center = true,
    border_size = 3
})

hl.window_rule({
    match = { class = "^(nm-connection-editor)$" },
    float = true,
    center = true,
    border_size = 3,
    size = { 800, 600 },
    opacity = "0.8 0.7"
})

hl.window_rule({
    match = { title = "^(nm-applet)$" },
    float = true,
    center = true,
    border_size = 3,
    size = { 800, 600 }
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$",
        title = "^(Copying)(.*)$"
    },
    float = true,
    center = true,
    border_size = 2
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$",
        title = "^(File Already Exists)(.*)$"
    },
    float = true,
    center = true,
    border_size = 2
})

hl.window_rule({
    match = {
        title = "^(Volume Control)(.*)$"
    },
    float = true,
    center = true,
    size = { 800, 600 },
    opacity = "0.8 0.7"
})

-- Picture-in-picture mode
hl.window_rule({
    match = {
	title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
    },
    float = true,
    keep_aspect_ratio = true,
    pin = true
})


-- APP SPECIFIC WINDOW RULES AHEAD
hl.window_rule({
    match = {
        class = "^(code)$"
    },
    -- opacity = "0.9 0.82"
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$"
    },
    opacity = "0.85 0.75"
})

hl.window_rule({
    match = {
        class = "^(zen)$"       -- zen browser
    },
    opacity = "1 0.82 1"
})

hl.window_rule({
    match = {
        class = "^(firefox)$"
    },
    opacity = "0.92 0.82"
})

hl.window_rule({
    match = {
        class = "^(kitty)$"
    },
    opacity = "1 0.8"
})

-- universal system dialog rule
hl.window_rule({
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
        title = "^(Open File|Save File|Select a Directory)(.*)$"
    },
    float = true,
    size = {800, 600},
    center = true
})

--[[
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
]]

---------------------------
--|   WORKSPACE RULES   |--
---------------------------

hl.workspace_rule({
    workspace = "special:magic",
    gaps_out = 24
})

-----------------------
--|   LAYER RULES   |--
-----------------------
-- Currently empty, plan to use when quickshell widgets are added
