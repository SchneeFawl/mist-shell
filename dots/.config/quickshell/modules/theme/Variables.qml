pragma Singleton
import QtQuick

QtObject {
    id: variables

    // General
    readonly property string defaultFontFamily: "GeistMono Nerd Font"
    readonly property int defaultFontWeight: 500

    // Animations
    readonly property var muiCurve: [0.38, 0.8, 0.22, 1.0, 1, 1]    // material ui curve
    readonly property var standardCurve: [0.3, 0.9, 0.4, 1.0, 1, 1]
    readonly property var overshootCurve: [0.33, 1.25, 0.76, 1.12, 1, 1]

    readonly property int durationFast: 170
    readonly property int durationMedium: 240
    readonly property int durationSlow: 320

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
