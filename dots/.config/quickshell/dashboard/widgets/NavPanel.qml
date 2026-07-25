import QtQuick
import QtQuick.Layouts
import qs.modules.theme
import qs.modules.common
import qs.services

Rectangle {

    property int activeTab: DashboardController.activeTab
    signal tabSelected(int index)

    id: navWrapper
    anchors.fill: parent
    color: "transparent"

    ColumnLayout {
        spacing: Variables.dashInnerColSpacing
        anchors.fill: parent

        BaseButton {
            id: mediaModeBtn
            btnSize: Variables.buttonHeightMedium
            radius: Variables.dashColumnRadius
            icon: Icons.navMusic
            iconSize: Variables.iconNormal
            onClicked: {
                navWrapper.activeTab = 1;
                navWrapper.tabSelected(1);
            }
            active: navWrapper.activeTab === 1
        }

        BaseButton {
            id: systemInfoBtn
            icon: Icons.navSystemInfo
            iconSize: Variables.iconNormal
            btnSize: Variables.buttonHeightMedium
            radius: Variables.dashColumnRadius
            onClicked: {
                navWrapper.activeTab = 2;
                navWrapper.tabSelected(2);
            }
            active: navWrapper.activeTab === 2
        }

        BaseButton {
            id: themeBtn
            icon: Icons.navTheme
            iconSize: Variables.iconNormal
            btnSize: Variables.buttonHeightMedium
            radius: Variables.dashColumnRadius
            onClicked: {
                navWrapper.activeTab = 3;
                navWrapper.tabSelected(3);
            }
            active: navWrapper.activeTab === 3
        }

        BaseButton {
            id: recordBtn
            icon: Icons.navRecord
            iconSize: Variables.iconNormal
            btnSize: Variables.buttonHeightMedium
            radius: Variables.dashColumnRadius
            onClicked: {
                navWrapper.activeTab = 4;
                navWrapper.tabSelected(4);
            }
            active: navWrapper.activeTab === 4
        }

        Item { Layout.fillHeight: true }        // filler

        BaseButton {
            id: settingsBtn
            icon: Icons.sysSettings
            iconSize: Variables.iconNormal
            btnSize: Variables.buttonHeightMedium
            radius: Variables.dashColumnRadius
            inactiveColor: Colors.surface_container_highest
            onClicked: {
                navWrapper.activeTab = 5;
                navWrapper.tabSelected(5);
            }
            active: navWrapper.activeTab === 5
        }
    }
}
