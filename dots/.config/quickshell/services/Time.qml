pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: timeRoot

    signal tick()

    property string timeText
    property string dayText
    property string dateText
    property string fullDateText

    function updateTime() {
        var d = new Date();
        timeText = d.toLocaleTimeString(Qt.locale(), "hh:mm AP");
        dayText = Qt.formatDate(d, "dddd");
        dateText = Qt.formatDate(d, "dd/M");
        fullDateText = Qt.formatDate(d, "dddd, dd MMMM yyyy");
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            timeRoot.updateTime();
            timeRoot.tick();
        }
    }
}
