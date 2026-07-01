import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.services
import "../Dashboard"
import "./components"

Item {
    id: centerModulesRoot

    implicitHeight: centerMediaPill.implicitHeight
    implicitWidth: centerMediaPill.implicitWidth
    height: implicitHeight
    width: implicitWidth

    property bool dashboardActive: false
    readonly property bool isHovered: pillHoverHandler.hovered || dashboard.hovered
    state: (isHovered || ThemeController.keyboardFocus) ? "active" : "inactive"

    Pill {
        id: centerMediaPill

        anchors.fill: parent
        implicitWidth: mediaText.width + Variables.pillInnerPadding * 2
        Behavior on implicitWidth {
            NumberAnimation {
                duration: Variables.durationMedium
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.standardCurve
            }
        }

        MediaText {
            id: mediaText
            Layout.alignment: Qt.AlignCenter
        }
    }

    HoverHandler {
        id: pillHoverHandler
    }

    states: [
        State {
            name: "inactive"
            PropertyChanges { centerModulesRoot.dashboardActive: false }
            PropertyChanges { centerMediaPill.opacity: 1.0 }
            // StateChangeScript { script: console.log("[CenterModules] State changed to 'inactive'") }     // DEBUG
        },
        State {
            name: "active"
            PropertyChanges { centerModulesRoot.dashboardActive: true }
            PropertyChanges { centerMediaPill.opacity: 0 }
            // StateChangeScript { script: console.log("[CenterModules] State changed to 'active'") }       // DEBUG
        }
    ]

    transitions: [
        Transition {
            from: "inactive"; to: "active"
            SequentialAnimation {
                PauseAnimation { duration: 500 }        // 500ms delay
                PropertyAction { target: centerModulesRoot; property: "dashboardActive" }
                NumberAnimation {
                    target: centerMediaPill
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        },
        Transition {
            from: "active"; to: "inactive"
            SequentialAnimation {
                PauseAnimation { duration: 600 }        // 600 ms delay
                PropertyAction { target: centerModulesRoot; property: "dashboardActive" }
                NumberAnimation {
                    target: centerMediaPill
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Variables.standardCurve
                }
            }
        }
    ]

    Dashboard {
        id: dashboard
        active: centerModulesRoot.dashboardActive
        centerPill: centerMediaPill
    }

    /* DEBUG: */
    // Connections {
    //     target: dashboard
    //     ignoreUnknownSignals: true
    //     function onHoveredChanged() {
    //         console.log("[CenterModules] Received dashboard.hovered notification:", dashboard.hovered, "| current isHovered:", centerModulesRoot.isHovered);
    //     }
    // }

    // onStateChanged: {
    //     console.log("[CenterModules] State changed to:", state,
    //                 "| isHovered:", isHovered,
    //                 "| pillHover:", pillHoverHandler.hovered,
    //                 "| dashHover:", dashboard.hovered,
    //                 "| kbFocus:", ThemeController.keyboardFocus)
    // }
}
