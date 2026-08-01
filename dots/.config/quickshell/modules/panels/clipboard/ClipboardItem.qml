import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: root

    // entryData: { id, text, isImage, rawEntry }
    property var entryData: null

    signal copyRequested()
    signal deleteRequested()

    Layout.fillWidth: true
    Layout.preferredHeight: {
        root.entryData?.isImage ?
        Math.round((100 * Variables.scaleFactor) + (Variables.spacingNormal * 2)) :
        Variables.buttonHeightMedium
    }
    color: Colors.surface_container_highest
    radius: Variables.radiusNormal
    scale: mouseArea.pressed ? 0.90 : 1.0
    clip: true

    Behavior on scale {
        NumberAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.exitCurve
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.copyRequested()
    }

    RowLayout {
        id: contentRow
        anchors.fill: parent
        // anchors.topMargin: Variables.spacingNormal
        // anchors.leftMargin: Variables.spacingMedium
        // anchors.rightMargin: Variables.spacingNormal
        // anchors.bottomMargin: Variables.spacingNormal
        anchors.margins: Variables.spacingNormal
        spacing: Variables.spacingNormal

        CliphistImage {
            visible: root.entryData?.isImage ? true : false
            rawEntry: root.entryData?.rawEntry ?? ""
            entryId: root.entryData?.id ?? ""
        }

        StyledText {
            Layout.fillWidth: true
            elide: Text.ElideRight
            maximumLineCount: 2
            text: root.entryData?.text ?? ""
        }

        Rectangle {     // separator
            Layout.fillHeight: true
            Layout.preferredWidth: Math.round(2 * Variables.scaleFactor)
            color: Colors.border_variant
            radius: width / 2
        }

        ClipboardButton {
            color: "transparent"
            implicitWidth: height
            Layout.fillHeight: true
            icon: Icons.actionDelete
            iconColor: Colors.error
            onClicked: root.deleteRequested()
        }
    }
}

