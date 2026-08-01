import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: clipRoot

    // property var entryData: { id, text, isImage, rawEntry }
    property var entryData: CliphistService.filteredEntries

    signal copyRequested()
    signal deleteRequested()

    Layout.fillWidth: true
    Layout.preferredHeight: {
        clipRoot.entryData?.isImage ?
        Math.round((100 * Variables.scaleFactor) + (Variables.spacingNormal * 2)) :
        Variables.buttonHeightMedium
    }
    color: Colors.surface_container_highest
    clip: true

    RowLayout {
        id: contentRow

        CliphistImage {
            visible: clipRoot.entryData?.isImage
        }
    }
}

