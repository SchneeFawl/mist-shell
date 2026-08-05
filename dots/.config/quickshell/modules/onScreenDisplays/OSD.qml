import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs.modules.theme
import qs.services

PanelWindow {       // qmllint disable uncreatable-type
    id: root

    // visible: OSDController.visible
    visible: true

    implicitHeight: Math.round(56 * Variables.scaleFactor)
    implicitWidth: Math.round(240 * Variables.scaleFactor)
    color: "transparent"

    anchors {
        top: true
    }
    margins {       // qmllint disable unresolved-type unqualified
        top: Variables.barHeight + Variables.spacingMedium
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
        border.color: Colors.border
        clip: true

        RowLayout {
            id: contentLayout
            anchors.fill: parent
            anchors.margins: Variables.spacingMedium
            spacing: Variables.spacingNormal

            StyledText {
                Layout.preferredWidth: Math.round(20 * Variables.scaleFactor)
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                leftPadding: Variables.spacingSmall
                color: OSDController.muted ? Colors.on_error_container : Colors.secondary
                font.pixelSize: Variables.iconMedium
                // text: OSDController.icon
                text: Icons.sysVolume
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: Variables.spacingNormal

                StyledText {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.on_secondary_container
                    font.pixelSize: Variables.fontMedium
                    // text: OSDController.title
                    text: "Volume"
                }

                Rectangle {
                    id: progressBar
                    Layout.preferredHeight: Math.round(6 * Variables.scaleFactor)
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

        HoverHandler {
            id: popupHover
            onHoveredChanged: {
                if (hovered) OSDController.stopTimer();
                else OSDController.startGraceTimer();
            }
        }
    }
}

