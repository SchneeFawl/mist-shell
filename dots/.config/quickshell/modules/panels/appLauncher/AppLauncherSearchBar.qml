import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {
    id: root

    required property ListView listView

    Layout.fillWidth: true
    Layout.preferredHeight: Math.round(40 * Variables.scaleFactor)
    color: Colors.secondary_container
    radius: Variables.radiusNormal
    clip: true

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Variables.spacingMedium
        spacing: Variables.spacingNormal
        clip: true

        StyledText {
            Layout.alignment: Text.AlignVCenter
            monospace: true
            font.pixelSize: Variables.iconNormal
            color: Colors.tertiary
            text: Icons.magnify
        }

        TextInput {
            id: searchInput
            Layout.alignment: Text.AlignVCenter
            Layout.fillWidth: true
            color: Colors.on_secondary_container
            font.family: Variables.sansFontFamily
            font.pixelSize: Variables.fontNormal
            cursorVisible: true
            clip: true
            onTextChanged: AppLauncherService.searchText = text
            enabled: root.visible
            focus: true

            StyledText {
                id: searchPlaceholder
                color: Colors.tertiary
                text: "Search applications..."
                visible: AppLauncherService.searchText.length === 0
            }

            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Down) {
                    if (root.listView.currentIndex < root.listView.count - 1) {
                        root.listView.currentIndex++;
                    }
                    event.accepted = true;
                } else if (event.key === Qt.Key_Up) {
                    if (root.listView.currentIndex > 0) {
                        root.listView.currentIndex--;
                    }
                    event.accepted = true;
                } else if ([Qt.Key_Enter, Qt.Key_Return].includes(event.key)) {
                    let currentApp = AppLauncherService.filteredApps[root.listView.currentIndex];
                    if (currentApp) AppLauncherService.launchApp(currentApp);
                    event.accepted = true;
                } else if (event.key === Qt.Key_Escape) {
                    AppLauncherService.visible = false;
                    event.accepted = true;
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            searchInput.forceActiveFocus();
        }
    }
}

