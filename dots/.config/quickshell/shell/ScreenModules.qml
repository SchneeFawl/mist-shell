pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

import qs.bar
import qs.modules
import qs.modules.screenCorners
import qs.modules.panels.clipboard
import qs.modules.onScreenDisplays
import qs.modules.screenLock
import qs.modules.settings

Scope {
    id: modulesRoot

    required property var modelData

    ModulesLoader {
        component: Bar {
            modelData: modulesRoot.modelData
        }
    }
    ModulesLoader { component: NotificationsPopup { modelData: modulesRoot.modelData } }
    ModulesLoader { component: ScreenCorners {} }
    ModulesLoader { component: Clipboard {} }
    ModulesLoader { component: SettingsWindow {} }
    ModulesLoader { component: OSD {} }
    ModulesLoader { component: LockScreen {} }
}

