------------------
--| AUTOSTART |---
------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("quickshell & disown")
    hl.exec_cmd("nm-applet")

    -- screenshare fix:
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 22")
end
)
