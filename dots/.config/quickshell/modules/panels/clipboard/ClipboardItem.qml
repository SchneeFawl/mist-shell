import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common

Rectangle {
    id: root

    // entryData: { id, text, isImage, rawEntry }
    property var entryData: null
    property bool selected
    property bool isCopied

    signal copyRequested()
    signal deleteRequested()

    implicitWidth: parent.width
    implicitHeight: {
        root.entryData?.isImage ?
        Math.round((100 * Variables.scaleFactor) + (Variables.spacingNormal * 2)) :
        Variables.buttonHeightMedium + Math.round(6 * Variables.scaleFactor)
    }
    color: (isCopied || selected) ? Colors.secondary : Colors.surface_container_highest
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

    Behavior on color {
        ColorAnimation {
            duration: Variables.durationMedium
            easing.type: Easing.Bezier
            easing.bezierCurve: Variables.standardCurve
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: !root.selected ? root.selected = true : root.isCopied = true;
        onDoubleClicked: root.isCopied = true;
    }

    RowLayout {
        id: contentRow
        anchors.fill: parent
        anchors.topMargin: Variables.spacingNormal
        anchors.leftMargin: Variables.spacingMedium
        anchors.rightMargin: Variables.spacingNormal
        anchors.bottomMargin: Variables.spacingNormal
        spacing: Variables.spacingNormal

        CliphistImage {
            visible: root.entryData?.isImage ? true : false
            rawEntry: root.entryData?.rawEntry ?? ""
            entryId: root.entryData?.id ?? ""
        }

        StyledText {
            Layout.fillWidth: true
            color: root.selected ? Colors.on_secondary : Colors.on_surface
            elide: Text.ElideRight
            maximumLineCount: 2
            text: root.entryData?.text ?? ""
        }

        // separator
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: Math.round(2 * Variables.scaleFactor)
            color: root.selected ? Colors.border : Colors.border_variant
            radius: width / 2
        }

        ClipboardButton {
            color: "transparent"
            implicitWidth: height
            Layout.fillHeight: true
            icon: Icons.actionDelete
            iconColor: root.selected ? Colors.on_error : Colors.error
            onClicked: root.deleteRequested()
        }
    }

    // DEBUG:
    // onIsCopiedChanged: console.log("[ClipboardItem] Copied entry")
    // onSelectedChanged: console.log("[ClipboardItem] Selected entry")
}

