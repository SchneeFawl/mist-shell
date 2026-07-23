import QtQuick
import QtQuick.Controls
import qs.modules.theme
import qs.services
import "./widgets/MainContent"      // qmllint disable unused-imports

Rectangle {
    id: contentRoot

    property int activeTab: DashboardController.activeTab
    property int previousTab: 1
    property bool isMovingDown: true

    onActiveTabChanged: {
        if (activeTab === previousTab) return;
        isMovingDown = activeTab > previousTab;
        previousTab = activeTab;
        stackView.replace(DashboardController.activeTabPath(activeTab));
    }

    anchors.fill: parent
    color: "transparent"
    clip: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: DashboardController.activeTabPath(DashboardController.activeTab)

        replaceEnter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
            NumberAnimation {
                property: "y"
                from: {
                    contentRoot.isMovingDown ?
                    Math.round(30 * Variables.scaleFactor) : -Math.round(30 * Variables.scaleFactor)
                }
                to: 0
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.entranceCurve
            }
        }

        replaceExit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
            NumberAnimation {
                property: "y"
                from: 0
                to: {
                    contentRoot.isMovingDown ?
                    -Math.round(30 * Variables.scaleFactor) : Math.round(30 * Variables.scaleFactor)
                }
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
        }
    }
}
