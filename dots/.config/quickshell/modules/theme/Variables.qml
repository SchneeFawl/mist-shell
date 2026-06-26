pragma Singleton
import QtQuick

QtObject {
    id: variables

    // General
    readonly property string defaultFontFamily: "GeistMono Nerd Font"
    readonly property int defaultFontWeight: 500

    // Animations
    readonly property var muiCurve: [0.38, 0.8, 0.22, 1, 1, 1]

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
    readonly property int dashColumnRadius: 14      // half of dashboardRadius
    readonly property int dashInnerColSpacing: 5
    readonly property int dashInnerRadius: 9    // dashColumnRadius - dashInnerColSpacing
    readonly property int dashIconSize: 20
}
