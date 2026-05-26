import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12

    // system stats pill
    Pill {
        BarText { text: " " + sysStats.cpuUsage + "%" }
        Rectangle { width: 1; height: 14; color: themePalette.pillBorder }
        BarText { text: " " + sysStats.usedMemory + "G" }
    }

    // active window workspace layout panel
    Pill {
        innerPadding: 10
        Workspaces {}
    }
}
