pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: brightRoot

    property int value
    property bool hasInBuiltDisplay: false
    property string valueMode: "increase"    // modes: increase, decrease, set
    
    Process {
        id: detectProc
        running: false
        command: ["brightnessctl", "-c", "backlight", "-m"]
        stdout: SplitParser {
            onRead: (data) => {
                if (data.trim().length > 0) {
                    brightRoot.hasInBuiltDisplay = true;
                    getBrightProc.running = true;
                }
            }
        }
    }

    Process {
        id: getBrightProc
        running: false
        command: ["brightnessctl", "-c", "backlight", "-m"]
        stdout: SplitParser {
            onRead: (data) => {
                let match = data.match(/,(\d+)%/)
                if (match) {
                    brightRoot.value = parseInt(match[1]);
                    console.log("[Brightness] Brightness:", brightRoot.value, "%");
                }
            }
        }
    }

    Process {
        id: setBrightProc
        running: false
        onExited: () => getBrightProc.running = true
    }

    function changeBrightness(mode, step = 5) {
        if (!brightRoot.hasInBuiltDisplay) return;

        let args = "";

        if (mode === "increase") {
            args = "+" + step + "%";
        } else if (mode === "decrease") {
            if (brightRoot.value - step < 0) {
                args = "1%";
            } else {
                args = step + "%-";
            }
        } else if (mode === "set") {
            let clamped = Math.max(1, Math.min(100, step));
            args = clamped + "%";
        }

        setBrightProc.command = ["brightnessctl", "set", args];
        setBrightProc.running = true;
    }

    Component.onCompleted: {
        detectProc.running = true;
        console.log("[Brightness] Initialized")
    }

    // `qs ipc brightness change increase 5`
    IpcHandler {
        target: "brightness"
        function change(mode: string, step: int): void {
            brightRoot.changeBrightness(mode, step);
        }
    }
}

