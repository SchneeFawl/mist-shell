pragma Singleton
import QtQuick

QtObject {
    id: variables

    // Overall
    readonly property string defaultFontFamily: "Maple Mono Normal"

    // Animations
    readonly property var muiCurve: [0.38, 0.8, 0.22, 1, 1, 1]

    // Bar
    readonly property int pillInnerPadding: 12
    readonly property int pillOuterSpacing: 12
    readonly property int pillHeight: 32
    readonly property int sideMargins: 16
    readonly property int workspaceOuterSize: 24
    readonly property int workspaceInnerSize: 8
    readonly property int maxBarMediaChars: 64

    // Dashboard
    readonly property int dashboardRadius: 28
    readonly property int dashColumnRadius: 14      // half of dashboardRadius
    readonly property int dashInnerColSpacing: 5
    readonly property int dashInnerRadius: 9    // dashColumnRadius - dashInnerColSpacing
    readonly property int dashIconSize: 24
}
