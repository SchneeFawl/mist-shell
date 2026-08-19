import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs.modules.theme
import qs.services

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    visible: OSDController.visible || popupRoot.opacity > 0.01

    implicitHeight: Variables.buttonHeightMedium
    implicitWidth: Math.round(240 * Variables.scaleFactor)
    color: "transparent"

    anchors {
        top: true
    }
    margins {       // qmllint disable unresolved-type unqualified
        top: Variables.barSize + Variables.spacingMedium
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "mist:osd_popup"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    Rectangle {
        id: popupRoot

        anchors.fill: parent
        color: Colors.surface_container
        radius: height / 2
        border.width: 2
        border.color: Colors.border_variant
        clip: true
        transformOrigin: Item.Top
        scale: OSDController.visible ? 1.0 : 0.8
        opacity: OSDController.visible ? 1.0 : 0.0

        RowLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.margins: Variables.spacingNormal
            spacing: Variables.spacingNormal

            StyledText {        // icon
                Layout.preferredWidth: Math.round(20 * Variables.scaleFactor)
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                leftPadding: Variables.spacingNormal
                color: OSDController.muted ? Colors.on_error_container : Colors.secondary
                font.pixelSize: Variables.iconMedium
                text: OSDController.icon
            }

            ColumnLayout {
                id: contentColumn
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

                Row {
                    id: textRow
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillHeight: true
                    spacing: Variables.spacingLargest

                    StyledText {
                        color: Colors.on_secondary_container
                        font.pixelSize: Variables.fontMedium
                        text: OSDController.title
                    }

                    StyledText {
                        color: Colors.on_secondary_container
                        font.pixelSize: Variables.fontMedium
                        font.weight: Variables.defaultFontWeight + 100      // bold
                        text: Math.round(OSDController.value * 100)
                    }
                }

                Rectangle {
                    id: progressBar
                    Layout.preferredHeight: Math.round(5 * Variables.scaleFactor)
                    Layout.fillWidth: true
                    Layout.leftMargin: Variables.spacingMedium
                    Layout.rightMargin: Variables.spacingMedium
                    Layout.bottomMargin: Variables.spacingSmall - Math.round(2 * Variables.scaleFactor)
                    radius: height / 2
                    color: OSDController.muted ? Colors.error : Colors.surface_container_highest
                    clip: true

                    Rectangle {
                        id: progress
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        radius: height / 2
                        color: OSDController.muted ? Colors.error : Colors.primary
                        implicitWidth: parent.width * Math.min(1.0, OSDController.value)

                        Behavior on implicitWidth {
                            NumberAnimation {
                                duration: Variables.durationFast
                                easing.type: Easing.Bezier
                                easing.bezierCurve: Variables.exitCurve
                            }
                        }
                    }
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }


        HoverHandler {
            id: popupHover
            onHoveredChanged: {
                if (hovered) OSDController.stopTimer();
                else OSDController.startGraceTimer();
            }
        }
    }
}

