import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import "./components"

PanelWindow {       // qmllint disable
    id: barWindow

    required property var modelData
    property string layoutStyle: "top-fragmented"

    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40
    exclusiveZone: 40
    color: "transparent"

    // wayland config bounds
    exclusionMode: ExclusionMode.Normal     // optinally: ExclusionMode.Exclude
    WlrLayershell.layer: WlrLayer.Top

    property bool popupVisible: false

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Variables.sideMargins
        anchors.rightMargin: Variables.sideMargins

        LeftModules {}

        Item { Layout.fillWidth: true }

        RightModules {}
    }

    CenterModules {
        id: centerModules
        anchors.centerIn: parent
    }
}
