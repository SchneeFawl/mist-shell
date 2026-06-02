import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {       // qmllint disable
    id: barWindow

    required property var targetScreen
    property string layoutStyle: "top-fragmented"

    screen: targetScreen
    anchors {
        top: true
        left: true
        right: true
    }

    height: 40
    exclusiveZone: 40
    color: "transparent"

    // wayland config bounds
    exclusionMode: ExclusionMode.Normal     // optinally: ExclusionMode.Exclude
    WlrLayershell.layer: WlrLayer.Top

    property bool popupVisible: false

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 0

        // modules here
        LeftModules {}

        Item { Layout.fillWidth: true }

        RightModules {}
    }

    CenterModules {
        id: centerModules
        anchors.centerIn: parent
    }
}
