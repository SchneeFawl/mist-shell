pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.theme

Scope {
    id: root

    property Component lockSurface: WlSessionLockSurface {
        id: lockSurface
        color: "transparent"

        LockSurface {
            anchors.centerIn: parent
            pamContext: pamContext
        }
    }

    WlSessionLock {
        id: lock

        locked: pamContext.locked
        surface: root.lockSurface
    }

    PamContext {
        id: pamContext

        IpcHandler {
            target: "lockscreen"

            function lock(): void {
                pamContext.locked = true;
            }
            function unlock(): void {
                pamContext.locked = false;
            }
        }
    }
}
