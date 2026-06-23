pragma Singleton
import QtQuick

QtObject {
    id: icons

    // Bar elements
    readonly property string barMedia: ""
    readonly property string barIcon: "󰣇"
    readonly property string barShortcuts: "󰌌"

    // System
    readonly property string powerIcon: "󰐥"
    readonly property string sysSettings: "󰒓"
    readonly property string sysDndActive: "󰂛"
    readonly property string sysDndInactive: "󰂚"
    readonly property string sysBluetooth: "󰂯"
    readonly property string sysGameMode: "󰺷"
    readonly property string sysCaffeineActive: "󰅶"
    readonly property string sysCaffeineInactive: "󰾪"
    readonly property string sysClipboard: "󰅍"
    readonly property string sysVolume: "󰕾"
    readonly property string sysVolumeMedium: "󰖀"
    readonly property string sysVolumeLow: "󰕿"
    readonly property string sysVolumeMute: "󰝟"
    readonly property string sysMic: "󰍬"
    readonly property string sysMicMute: "󰍭"
    readonly property string sysBrightness: "󰃟"

    // Media controls
    readonly property string mediaPlay: ""
    readonly property string mediaPause: ""
    readonly property string mediaNext: "󰒭"
    readonly property string mediaPrevious: "󰒮"
    readonly property string mediaLoopNone: "󰑗"
    readonly property string mediaLoopTrack: "󰑘"
    readonly property string mediaLoopPlaylist: "󰑖"

    // Decorations
    readonly property string dot: "•"

    // DASHBOARD:
    // navPanel
    readonly property string navApps: "󰀻"
    readonly property string navSystemInfo: ""
    readonly property string navMusic: "󰽴"
    readonly property string navTheme: "󰏘"

    // General controls/actions
    readonly property string actionClear: "󰃢"
    readonly property string moonCrescent: "󰽧"
    readonly property string sunBright: "󰃠"
    readonly property string magnify: "󰍉"
    readonly property string refresh: "󰑐"
}
