pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool visible: false
    property string searchText: ""
    readonly property int totalAppCount: DesktopEntries.applications.values.length

    readonly property var filteredApps: {
        let all = DesktopEntries.applications.values || [];
        if (root.searchText.trim() === "") return all;
        let query = root.searchText.toLowerCase();
        return all.filter(app =>
            (app.name && app.name.toLowerCase().includes(query)) ||
            (app.comment && app.comment.toLowerCase().includes(query))
        );
    }

    function launchApp(app) {
        app.execute();
        root.visible = false;
        root.searchText = "";
    }

    IpcHandler {
        target: "applauncher"
        function toggle(): void {
            root.visible = !root.visible;
            if (!root.visible) root.searchText = "";
        }

        function open(): void {
            root.visible = true;
        }

        function close(): void {
            root.visible = false;
            root.searchText = "";
        }
    }
}
