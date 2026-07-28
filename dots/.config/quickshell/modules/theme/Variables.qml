pragma Singleton
import QtQuick
import qs.services

QtObject {
    id: variables

    // General
    readonly property real scaleFactor: SettingsService.scaleFactor
    readonly property int screenCornerRadius: (barHeight - pillHeight) + pillRadius

    // Animations
    readonly property var standardCurve:  [0.30, 0.90, 0.40, 1.0, 1, 1]
    readonly property var overshootCurve: [0.18, 1.1, 0.7, 1.10, 1, 1]
    readonly property var entranceCurve:  [0, 0, 0.2, 1.0, 1, 1]
    readonly property var exitCurve:      [0.10, 0.80, 0.60, 1.0, 1, 1]

    // Text
    readonly property string defaultFontFamily: "GeistMono Nerd Font"
    readonly property int defaultFontWeight: 500

    readonly property int fontSmall:   Math.round(12 * scaleFactor)
    readonly property int fontNormal:  Math.round(14 * scaleFactor)
    readonly property int fontMedium:  Math.round(16 * scaleFactor)
    readonly property int fontLarge:   Math.round(20 * scaleFactor)
    readonly property int fontLargest: Math.round(24 * scaleFactor)

    readonly property int iconSmall:   Math.round(16 * scaleFactor)
    readonly property int iconNormal:  Math.round(20 * scaleFactor)
    readonly property int iconLarge:   Math.round(24 * scaleFactor)
    readonly property int iconLargest: Math.round(30 * scaleFactor)

    readonly property int durationFast:   160
    readonly property int durationMedium: 240
    readonly property int durationSlow:   300

    // Common
    readonly property int spacingSmall:   Math.round(4 * scaleFactor)
    readonly property int spacingNormal:  Math.round(8 * scaleFactor)
    readonly property int spacingMedium:  Math.round(12 * scaleFactor)
    readonly property int spacingLarge:   Math.round(16 * scaleFactor)

    readonly property int radiusSmall:    Math.round(4 * scaleFactor)
    readonly property int radiusNormal:   Math.round(8 * scaleFactor)
    readonly property int radiusMedium:   Math.round(12 * scaleFactor)
    readonly property int radiusLarge:    Math.round(16 * scaleFactor)

    // Bar
    readonly property int barHeight:             Math.round(40 * scaleFactor)
    readonly property int pillHeight:            Math.round(32 * scaleFactor)
    readonly property int pillRadius:            Math.round(12 * scaleFactor)
    readonly property int pillInnerPadding:      Math.round(12 * scaleFactor)
    readonly property int pillInnerSpacing:      Math.round(6 * scaleFactor)
    readonly property int pillOuterSpacing:      Math.round(12 * scaleFactor)
    readonly property int barSideMargins:        barHeight - pillHeight - Math.round(2 * scaleFactor)
    readonly property int workspaceActiveSize:   Math.round(32 * scaleFactor)
    readonly property int workspaceInactiveSize: Math.round(16 * scaleFactor)
    readonly property int maxBarMediaChars:      Math.round(36 * scaleFactor)

    // Dashboard
    readonly property int dashboardRadius:     Math.round(28 * scaleFactor)
    readonly property int dashColumnRadius:    Math.round(14 * scaleFactor)
    readonly property int dashInnerColSpacing: Math.round(5 * scaleFactor)
    readonly property int dashInnerRadius:     dashColumnRadius - dashInnerColSpacing

    // Controls
    readonly property int buttonHeightSmallest: Math.round(16 * scaleFactor)
    readonly property int buttonHeightSmall:    Math.round(30 * scaleFactor)
    readonly property int buttonHeight:         Math.round(36 * scaleFactor)
    readonly property int buttonHeightMedium:   Math.round(50 * scaleFactor)
}
