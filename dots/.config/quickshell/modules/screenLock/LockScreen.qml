import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.common
import qs.modules.theme

Scope {
    id: root

    property Component lockSurface: WlSessionLockSurface {
        id: lockSurface
        color: Colors.surface_container_low
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

