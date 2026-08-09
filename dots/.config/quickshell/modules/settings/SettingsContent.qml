import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.theme

Rectangle {
    id: root

    property var pages: []
    property int currentPage: 0

    readonly property string currentComponentPath: pages[currentPage]?.component ?? ""

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: Colors.surface_container
    radius: Variables.radiusNormal

    Loader {
        anchors.fill: parent
        anchors.margins: Variables.spacingMedium
        source: root.currentComponentPath !== "" ? Qt.resolvedUrl(root.currentComponentPath) : ""
    }
}
