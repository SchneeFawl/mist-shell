------------------
--| AUTOSTART |---
------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("quickshell")
    hl.exec_cmd("nm-applet")
    -- hl.exec_cmd("waybar & hyprpaper & firefox")
end
)

