import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs.modules.theme
import qs.services

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    visible: OSDController.visible
    // visible: true

    anchors {
        top: true
    }
    margins {       // qmllint disable unresolved-type unqualified
        top: Variables.barHeight + Variables.spacingMedium
    }
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "mist:osd_popup"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    Rectangle {
        id: popupRoot
        implicitHeight: Math.round(64 * Variables.scaleFactor)
        implicitWidth: Math.round(300 * Variables.scaleFactor)
        color: Colors.surface_container
        radius: width / 2
        border.width: 2
        border.color: Colors.border
    }
}

