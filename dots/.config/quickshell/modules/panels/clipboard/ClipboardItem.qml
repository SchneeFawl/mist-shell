import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: root

    // entryData: { id, text, isImage, rawEntry }
    property var entryData: null
    readonly property bool selected: CliphistService.selectedId === (entryData?.id ?? "")
    property bool isCopied

    signal copyRequested()
    signal deleteRequested()

    implicitWidth: parent.width
    implicitHeight: {
        root.entryData?.isImage ?
        Math.round((120 * Variables.scaleFactor) + (Variables.spacingNormal * 2)) :
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
        onClicked: {
            if (!root.selected) CliphistService.selectedId = root.entryData?.id ?? "";
            else root.isCopied = true;
        }
        onDoubleClicked: root.copyTriggered()
    }

    StyledText {
        anchors.centerIn: parent
        font.pixelSize: Variables.fontMedium
        color: Colors.on_secondary
        text: "Copied!"
        opacity: root.isCopied ? 1.0 : 0.0
    }

    RowLayout {
        id: contentRow
        anchors.fill: parent
        anchors.topMargin: Variables.spacingNormal
        anchors.leftMargin: Variables.spacingMedium
        anchors.rightMargin: Variables.spacingNormal
        anchors.bottomMargin: Variables.spacingNormal
        spacing: Variables.spacingNormal
        opacity: root.isCopied ? 0.0 : 1.0

        StyledText {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: root.selected ? Colors.on_secondary : Colors.on_surface
            elide: Text.ElideRight
            maximumLineCount: 2
            textFormat: Text.PlainText
            visible: root.entryData?.isImage ? false : true
            text: root.entryData?.text ?? ""
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: root.entryData?.isImage ? true : false

            CliphistImage {
                rawEntry: root.entryData?.rawEntry ?? ""
                entryId: root.entryData?.id ?? ""
            }
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
            Layout.preferredWidth: Math.round((56 * Variables.scaleFactor) - (Variables.spacingNormal * 2))
            Layout.fillHeight: true
            icon: Icons.actionDelete
            iconColor: root.selected ? Colors.on_error : Colors.error
            onClicked: root.deleteRequested()
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Variables.durationFast
                easing.type: Easing.Bezier
                easing.bezierCurve: Variables.exitCurve
            }
        }
    }

    function copyTriggered() {
        isCopied = true;
        CliphistService.copy(entryData.rawEntry);
        copyTimer.start();
    }

    Timer {
        id: copyTimer
        repeat: false
        running: false
        interval: 1000
        onTriggered: {
            CliphistService.panelVisible = false;
            root.isCopied = false;
            CliphistService.selectedId = false;
        }
    }
}

