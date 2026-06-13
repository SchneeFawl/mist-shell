import QtQuick
import QtQuick.Layouts
import qs.services
import "./Dashboard"

// qmllint disable unqualified

Item {
    id: centerModulesRoot

    implicitHeight: centerMediaPill.implicitHeight
    implicitWidth: centerMediaPill.implicitWidth

    property bool dashboardActive: false

    Pill {
        id: centerMediaPill
        anchors.fill: parent

        opacity: centerModulesRoot.dashboardActive ? 0 : 1
        Behavior on opacity { NumberAnimation { duration: 500 } }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            BarText {
                property var activePlayer: MprisController.activePlayer

                Layout.alignment: Qt.AlignCenter
                text: MprisController.activePlayer ?
                    "󰕮 " + activePlayer.trackTitle + " - " + activePlayer.trackArtist
                    : "󰕮 No media playing"
                color: themePalette.textVibrant
                font.pixelSize: 14
            }
        }
    }

    Timer {
        id: openTimer
        interval: 500
        repeat: false
        onTriggered: centerModulesRoot.dashboardActive = true
    }

    Timer {
        id: closeTimer
        interval: 600
        repeat: false
        onTriggered: centerModulesRoot.dashboardActive = false
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            closeTimer.stop();
            if (!centerModulesRoot.dashboardActive) openTimer.start();
        }
        onExited: {
            openTimer.stop();
            if (centerModulesRoot.dashboardActive) closeTimer.start();
        }
    }

    Dashboard {
        id: dashboard
        active: centerModulesRoot.dashboardActive
        centerPill: centerMediaPill
        closeTimer: closeTimer
    }
}
