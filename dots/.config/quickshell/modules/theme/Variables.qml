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
    readonly property int fontSmall:   Math.round(12 * scaleFactor)
    readonly property int fontNormal:  Math.round(14 * scaleFactor)
    readonly property int fontMedium:  Math.round(16 * scaleFactor)
    readonly property int fontLarge:   Math.round(20 * scaleFactor)
    readonly property int fontLargest: Math.round(24 * scaleFactor)

    // Animations
    readonly property var standardCurve:  [0.30, 0.90, 0.40, 1.0, 1, 1]
    readonly property var overshootCurve: [0.18, 1.1, 0.7, 1.10, 1, 1]
    readonly property var entranceCurve:  [0, 0, 0.2, 1.0, 1, 1]
    readonly property var exitCurve:      [0.10, 0.80, 0.60, 1.0, 1, 1]

    readonly property int durationFast: 160
    readonly property int durationMedium: 240
    readonly property int durationSlow: 300

    // Common
    readonly property int screenCornerRadius: (barHeight - pillHeight) + pillRadius

    // Bar
    readonly property int barHeight:             Math.round(40 * scaleFactor)
    readonly property int pillHeight:            Math.round(32 * scaleFactor)
    readonly property int pillRadius:            Math.round(12 * scaleFactor)
    readonly property int pillInnerPadding:      Math.round(12 * scaleFactor)
    readonly property int pillOuterSpacing:      Math.round(12 * scaleFactor)
    readonly property int barSideMargins:        barHeight - pillHeight - 2
    readonly property int workspaceActiveSize:   Math.round(32 * scaleFactor)
    readonly property int workspaceInactiveSize: Math.round(16 * scaleFactor)
    readonly property int maxBarMediaChars:      Math.round(48 * scaleFactor)

    // Dashboard
    readonly property int dashboardRadius:     Math.round(28 * scaleFactor)
    readonly property int dashColumnRadius:    Math.round(14 * scaleFactor)
    readonly property int dashInnerColSpacing: Math.round(5 * scaleFactor)
    readonly property int dashInnerRadius:     dashColumnRadius - dashInnerColSpacing
    readonly property int dashIconSize:        Math.round(20 * scaleFactor)

    // Controls
    readonly property int buttonHeight:        Math.round(36 * scaleFactor)
}
