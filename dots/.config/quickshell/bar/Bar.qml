import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services

PanelWindow {       // qmllint disable
    id: bar
    
    // qmllint disable missing-property

    required property var modelData
    readonly property string position: SettingsService.bar?.position ?? "top"
    readonly property bool isVertical: position.startsWith("vertical") || position === "left" || position === "right"
    readonly property string style: "fragmented"

    screen: modelData
    anchors {
        top: !isVertical ? (position === "top") : true
        left: !isVertical ? true : (position.includes("left"))
        right: !isVertical ? true : (position.includes("right"))
        bottom: !isVertical ? (position === "bottom") : true
    }

    implicitHeight: !isVertical ? Variables.barSize : screen.height
    implicitWidth: isVertical ? Variables.barSize : screen.width
    exclusiveZone: Variables.barSize
    color: "transparent"

    // wayland config bounds
    exclusionMode: ExclusionMode.Normal     // optinally: ExclusionMode.Exclude
    WlrLayershell.layer: WlrLayer.Top

    property bool popupVisible: false

    Loader {
        anchors.fill: parent
        sourceComponent: bar.isVertical ? verticalLayout: horizontalLayout
    }

    Component {
        id: horizontalLayout

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
    }

    Component {
        id: verticalLayout
        Item {}
    }

    CenterModules {
        id: centerModules
        anchors.centerIn: parent
    }
}
