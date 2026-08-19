pragma Singleton
import QtQuick
import qs.services

// qmllint disable missing-property

QtObject {
    id: variables

    readonly property real radiusMultiplier:   SettingsService.appearance.radiusMultiplier
    readonly property real spacingMultiplier:  SettingsService.appearance.spacingMultiplier
    readonly property real fontSizeMultiplier: SettingsService.appearance.fontSizeMultiplier
    readonly property real iconSizeMutliplier: SettingsService.appearance.iconSizeMultiplier

    // General
    readonly property real scaleFactor: SettingsService.display.scaleFactor
    readonly property int screenCornerRadius: (barSize - pillHeight) + pillRadius

    readonly property real panelOpacity: 0.7

    // Animations
    readonly property var standardCurve:  [0.30, 0.90, 0.40, 1.0, 1, 1]
    readonly property var overshootCurve: [0.18, 1.1, 0.7, 1.10, 1, 1]
    readonly property var entranceCurve:  [0, 0, 0.2, 1.0, 1, 1]
    readonly property var exitCurve:      [0.10, 0.80, 0.60, 1.0, 1, 1]

    // Text
    readonly property string monoFontFamily: SettingsService.general.monoFontFamily
    readonly property string defaultFontFamily: monoFontFamily          // backwards compatibility
    readonly property string sansFontFamily: SettingsService.general.sansFontFamily
    readonly property int defaultFontWeight: 500

    readonly property int fontSmall:   Math.round(12 * scaleFactor * fontSizeMultiplier)
    readonly property int fontNormal:  Math.round(14 * scaleFactor * fontSizeMultiplier)
    readonly property int fontMedium:  Math.round(16 * scaleFactor * fontSizeMultiplier)
    readonly property int fontLarge:   Math.round(20 * scaleFactor * fontSizeMultiplier)
    readonly property int fontLargest: Math.round(24 * scaleFactor * fontSizeMultiplier)

    readonly property int iconSmall:   Math.round(16 * scaleFactor * iconSizeMutliplier)
    readonly property int iconNormal:  Math.round(20 * scaleFactor * iconSizeMutliplier)
    readonly property int iconMedium:  Math.round(22 * scaleFactor * iconSizeMutliplier)
    readonly property int iconLarge:   Math.round(24 * scaleFactor * iconSizeMutliplier)
    readonly property int iconLargest: Math.round(30 * scaleFactor * iconSizeMutliplier)

    readonly property int durationFast:   160
    readonly property int durationMedium: 240
    readonly property int durationSlow:   300

    // Common
    readonly property int spacingSmallest: Math.round(2 * scaleFactor * spacingMultiplier)
    readonly property int spacingSmall:    Math.round(4  * scaleFactor * spacingMultiplier)
    readonly property int spacingNormal:   Math.round(8  * scaleFactor * spacingMultiplier)
    readonly property int spacingMedium:   Math.round(12 * scaleFactor * spacingMultiplier)
    readonly property int spacingLarge:    Math.round(16 * scaleFactor * spacingMultiplier)
    readonly property int spacingLargest:  Math.round(20 * scaleFactor * spacingMultiplier)

    readonly property int radiusSmall:   Math.round(4  * scaleFactor * radiusMultiplier)
    readonly property int radiusNormal:  Math.round(8  * scaleFactor * radiusMultiplier)
    readonly property int radiusMedium:  Math.round(12 * scaleFactor * radiusMultiplier)
    readonly property int radiusLarge:   Math.round(16 * scaleFactor * radiusMultiplier)
    readonly property int radiusLargest: Math.round(20 * scaleFactor * radiusMultiplier)

    // Bar
    readonly property int barSize: Math.round(40 * scaleFactor)
    readonly property int barSideMargins: barSize - pillHeight - Math.round(2 * scaleFactor)
    readonly property int barTopMargin: barSize - pillHeight - spacingSmall - spacingSmallest
    readonly property int pillHeight: Math.round(32 * scaleFactor)
    readonly property int pillRadius: Math.round(12 * scaleFactor * radiusMultiplier)
    readonly property int pillInnerPadding: Math.round(12 * scaleFactor * spacingMultiplier)
    readonly property int pillInnerSpacing: Math.round(6 * scaleFactor * spacingMultiplier)
    readonly property int pillOuterSpacing: Math.round(12 * scaleFactor * spacingMultiplier)
    readonly property int workspaceActiveSize: Math.round(32 * scaleFactor)
    readonly property int workspaceInactiveSize: Math.round(16 * scaleFactor)
    readonly property int maxBarMediaChars: Math.round(36 * scaleFactor)

    // Dashboard
    readonly property int dashboardRadius:     Math.round(28 * scaleFactor * variables.radiusMultiplier)
    readonly property int dashColumnRadius:    Math.round(14 * scaleFactor * variables.radiusMultiplier)
    readonly property int dashInnerColSpacing: Math.round(5 * scaleFactor * variables.spacingMultiplier)
    readonly property int dashInnerRadius:     dashColumnRadius - dashInnerColSpacing

    // Controls
    readonly property int buttonHeightSmallest: Math.round(16 * scaleFactor)
    readonly property int buttonHeightSmall:    Math.round(30 * scaleFactor)
    readonly property int buttonHeight:         Math.round(36 * scaleFactor)
    readonly property int buttonHeightMedium:   Math.round(50 * scaleFactor)
    readonly property int buttonHeightLarge:    Math.round(56 * scaleFactor)
    readonly property int buttonHeightLargest:  Math.round(64 * scaleFactor)
}
