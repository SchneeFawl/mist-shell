pragma Singleton
import QtQuick

QtObject {
    id: variables

    // General
    readonly property string defaultFontFamily: "GeistMono Nerd Font"
    readonly property int defaultFontWeight: 500

    // Animations
    readonly property var muiCurve:       [0.38, 0.80, 0.22, 1.0, 1, 1]    // material ui curve
    readonly property var standardCurve:  [0.30, 0.90, 0.40, 1.0, 1, 1]
    readonly property var overshootCurve: [0.18, 1.1, 0.7, 1.10, 1, 1]
    readonly property var entranceCurve:  [0, 0, 0.2, 1.0, 1, 1]
    readonly property var exitCurve:      [0.10, 0.80, 0.60, 1.0, 1, 1]

    readonly property int durationFast: 160
    readonly property int durationMedium: 240
    readonly property int durationSlow: 300

    // Bar
    readonly property int pillInnerPadding: 12
    readonly property int pillOuterSpacing: 12
    readonly property int pillRadius: 12
    readonly property int pillHeight: 32
    readonly property int barSideMargins: 16
    readonly property int workspaceActiveSize: 32
    readonly property int workspaceInactiveSize: 16
    readonly property int maxBarMediaChars: 48

    // Dashboard
    readonly property int dashboardRadius: 28
    readonly property int dashColumnRadius: 14
    readonly property int dashInnerColSpacing: 5
    readonly property int dashInnerRadius: 9    // dashColumnRadius - dashInnerColSpacing
    readonly property int dashIconSize: 20
}
