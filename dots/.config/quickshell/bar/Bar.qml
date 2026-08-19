import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.modules.theme

PanelWindow {       // qmllint disable
    id: barWindow

    required property var modelData
    property string position: "top"
    property string style: "fragmented"

    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Variables.barHeight
    exclusiveZone: Variables.barHeight
    color: "transparent"

    // wayland config bounds
    exclusionMode: ExclusionMode.Normal     // optinally: ExclusionMode.Exclude
    WlrLayershell.layer: WlrLayer.Top

    property bool popupVisible: false

    RowLayout {
        anchors.fill: parent
        anchors.topMargin: Variables.barTopMargin
        anchors.leftMargin: Variables.barSideMargins
        anchors.rightMargin: Variables.barSideMargins

        LeftModules {
            Layout.fillHeight: true
        }

        Item { Layout.fillWidth: true }

        RightModules {
            Layout.fillHeight: true
        }
    }

    CenterModules {
        id: centerModules
        anchors.centerIn: parent
    }
}
