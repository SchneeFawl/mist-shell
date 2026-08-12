pragma Singleton
import QtQuick

QtObject {
    id: icons

    // Bar elements
    readonly property string barMedia: ""
    readonly property string barIcon: "󰣇"

    // System
    readonly property string powerIcon: "󰐥"
    readonly property string archLinux: "󰣇"
    readonly property string settings: "󰒓"
    readonly property string sliders: "󰘮"
    readonly property string sysDndActive: "󰂛"
    readonly property string sysDndInactive: "󰂚"
    readonly property string sysBluetooth: "󰂯"
    readonly property string sysGameMode: "󰺷"
    readonly property string sysCaffeineActive: "󰅶"
    readonly property string sysCaffeineInactive: "󰾪"
    readonly property string clipboard: "󰅍"

    readonly property string sysVolume: "󰕾"
    readonly property string sysVolumeMedium: "󰖀"
    readonly property string sysVolumeLow: "󰕿"
    readonly property string sysVolumeMute: "󰝟"
    readonly property string sysMic: "󰍬"
    readonly property string sysMicMute: "󰍭"
    readonly property string sysBrightness: "󰃟"

    readonly property string at: "󰁥"
    readonly property string account: "󰀄"

    // Media controls
    readonly property string mediaPlay: ""
    readonly property string mediaPause: ""
    readonly property string mediaNext: "󰒭"
    readonly property string mediaPrevious: "󰒮"
    readonly property string mediaLoopNone: "󰑗"
    readonly property string mediaLoopTrack: "󰑘"
    readonly property string mediaLoopPlaylist: "󰑖"

    // Menu elements
    readonly property string dot: "•"
    readonly property string chevronLeft: "󰅁"
    readonly property string chevronRight: "󰅂"
    readonly property string chevronDown: "󰅀"
    readonly property string chevronUp: "󰅃"
    readonly property string minus: "󰍴"
    readonly property string checkMark: "󰄬"
    readonly property string close: "󰅖"

    readonly property string recorder: "󰻂"
    readonly property string systemInfo: ""
    readonly property string music: "󰽴"
    readonly property string palette: "󰏘"

    // General controls/actions
    readonly property string actionClear: "󰃢"
    readonly property string moonCrescent: "󰽧"
    readonly property string sunBright: "󰃠"
    readonly property string magnify: "󰍉"
    readonly property string refresh: "󰑐"
    readonly property string recording: "󰻃"
    readonly property string record: "󰑊"
    readonly property string replay: "󰑙"
    readonly property string stopRecording: "󰙧"
    readonly property string save: "󰆓"
    readonly property string actionDelete: "󰆴"
    readonly property string restoreDefault: "󰁯"

    // Devices
    readonly property string headphones: "󰋋"
    readonly property string headset: "󰋎"
    readonly property string mouse: "󰍽"
    readonly property string keyboard: "󰌌"
    readonly property string laptop: "󰌢"
    readonly property string monitor: "󰍹"
    readonly property string television: "󰔂"
    readonly property string phone: "󰏲"

    // Battery
    readonly property string batteryCharging: "󰂄"
    readonly property string batteryFull: "󰁹"
    readonly property string batteryAlert: "󰂃"  // < 10%
    readonly property string battery10: "󰁺"
    readonly property string battery20: "󰁻"
    readonly property string battery30: "󰁼"
    readonly property string battery40: "󰁽"
    readonly property string battery50: "󰁾"
    readonly property string battery60: "󰁿"
    readonly property string battery70: "󰂀"
    readonly property string battery80: "󰂁"
    readonly property string battery90: "󰂂"

    // Thermometer/Temps
    property string thermometer: "󰔏"
    property string thermometerLow: "󱃃"
    property string thermometerHigh: "󱃂"
    property string thermometerAlert: "󰸁"   // >90 C
    property string tempCelsius: "󰔄"

    readonly property string cpu: ""
    readonly property string ram: ""
    readonly property string database: "󰆼"
    readonly property string databaseAlert: "󱘺"

    readonly property string dockTop: "󱔓"

    readonly property string textShadow: "󰙩"
}
