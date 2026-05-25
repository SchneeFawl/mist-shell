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
    match = { title = "^(nm-connection-editor)$" },
    float = true,
    center = true,
    border_size = 3
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
    size = {800, 600}
})

-- universal system dialog rule
hl.window_rule({
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
        title = "^(Open File|Save File|Select a Directory)(.*)$"
    },
    float = true,
    size =  {800, 600},
    center = true
})


-----------------------
--|   LAYER RULES   |--
-----------------------
-- Currently empty, plan to use when quickshell widgets are added
