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

    implicitHeight: 36
    exclusiveZone: 39
    color: "transparent"

    // wayland config bounds
    exclusionMode: ExclusionMode.Normal     // optinally: ExclusionMode.Exclude
    WlrLayershell.layer: WlrLayer.Top

    // visual background container
    Rectangle {
        anchors.fill: parent
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 0

            // modules here
            LeftModules { Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter }

            Item { Layout.fillWidth: true }

            CenterModules { Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter }

            Item { Layout.fillWidth: true }

            RightModules { Layout.alignment: Qt.AlignRight | Qt.AlignVCenter }
        }
    }
}
