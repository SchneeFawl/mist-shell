import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.modules.theme
import "../components"

ColumnLayout {
    id: btMenuRoot

    signal backClicked()

    anchors.fill: parent
    anchors.margins: Variables.dashInnerColSpacing
    spacing: Variables.dashInnerColSpacing

    // header
    RowLayout {
        BTButton {
            id: backButton
            onClicked: btMenuRoot.backClicked()
        }
    }
}
