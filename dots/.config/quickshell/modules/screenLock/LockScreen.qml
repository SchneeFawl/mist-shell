pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.theme

Scope {
    id: root

    property Component lockSurface: WlSessionLockSurface {
        id: lockSurface
        color: "black"

        ScreencopyView {
            anchors.fill: parent
            live: false
            captureSource: lockSurface.screen

            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blurMax: 48
                blur: 1.0
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Colors.surface_container_low
            opacity: 0.35
        }

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
