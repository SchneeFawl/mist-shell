import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.modules.theme
import qs.modules.common

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    property string searchText: ""
    readonly property var filteredEntries: {
        if (searchText.trim() === "") return CliphistService.entries;
        let query = searchText.toLowerCase();
        return CliphistService.entries.filter(entry => entry.text.toLowerCase().includes(query));
    }

    implicitHeight: Math.round(450 * Variables.scaleFactor)
    implicitWidth: Math.round(300 * Variables.scaleFactor)
    color: Colors.surface_container_low
    visible: CliphistService.panelVisible

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "clipboard_window"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    // exclusiveZone: -1

    ClipboardHeader {
        searchQuery: root.searchText
    }
}
