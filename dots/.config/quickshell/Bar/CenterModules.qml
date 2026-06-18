import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import "./Dashboard"
import "./components"

Item {
    id: centerModulesRoot

    implicitHeight: centerMediaPill.implicitHeight
    implicitWidth: centerMediaPill.implicitWidth

    property bool dashboardActive: false

    Pill {
        id: centerMediaPill

        anchors.fill: parent
        implicitWidth: mediaText.width + Variables.pillInnerPadding * 2
        Behavior on implicitWidth { NumberAnimation { duration: 230; easing.type: Easing.OutCubic } }

        opacity: centerModulesRoot.dashboardActive ? 0 : 1
        Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }

        BarText {
            id: mediaText
            Layout.alignment: Qt.AlignCenter
            font.pixelSize: 14
            text: activeText

            onDisplayedTextChanged: textSwapAnim.restart()

            SequentialAnimation {
                id: textSwapAnim

                NumberAnimation {
                    target: mediaText
                    property: "opacity"
                    to: 0.0
                    duration: 150
                    easing.type: Easing.OutQuad
                }

                ScriptAction {
                    script: mediaText.activeText = mediaText.displayedText
                }

                NumberAnimation {
                    target: mediaText
                    property: "opacity"
                    to: 1.0
                    duration: 150
                    easing.type: Easing.OutQuad
                }
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
