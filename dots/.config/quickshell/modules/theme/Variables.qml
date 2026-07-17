pragma Singleton
import QtQuick
import qs.services

QtObject {
    id: variables

    // General
    readonly property real scaleFactor: SettingsService.scaleFactor

    // Text
    readonly property string defaultFontFamily: "GeistMono Nerd Font"
    readonly property int defaultFontWeight: 500
    readonly property int defaultFontSize: Math.round(14 * scaleFactor)

    // Animations
    readonly property var standardCurve:  [0.30, 0.90, 0.40, 1.0, 1, 1]
    readonly property var overshootCurve: [0.18, 1.1, 0.7, 1.10, 1, 1]
    readonly property var entranceCurve:  [0, 0, 0.2, 1.0, 1, 1]
    readonly property var exitCurve:      [0.10, 0.80, 0.60, 1.0, 1, 1]

    readonly property int durationFast: 160
    readonly property int durationMedium: 240
    readonly property int durationSlow: 300

    // Bar
    readonly property int pillInnerPadding:      Math.round(12 * scaleFactor)
    readonly property int pillOuterSpacing:      Math.round(12 * scaleFactor)
    readonly property int pillRadius:            Math.round(12 * scaleFactor)
    readonly property int pillHeight:            Math.round(32 * scaleFactor)
    readonly property int barSideMargins:        Math.round(16 * scaleFactor)
    readonly property int workspaceActiveSize:   Math.round(32 * scaleFactor)
    readonly property int workspaceInactiveSize: Math.round(16 * scaleFactor)
    readonly property int maxBarMediaChars:      Math.round(48 * scaleFactor)

    // Dashboard
    readonly property int dashboardRadius:     Math.round(28 * scaleFactor)
    readonly property int dashColumnRadius:    Math.round(14 * scaleFactor)
    readonly property int dashInnerColSpacing: Math.round(5 * scaleFactor)
    readonly property int dashInnerRadius:     dashColumnRadius - dashInnerColSpacing
    readonly property int dashIconSize:        Math.round(20 * scaleFactor)
}
