------------------
--| AUTOSTART |---
------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("quickshell & disown")
    hl.exec_cmd("nm-applet")
end
)

