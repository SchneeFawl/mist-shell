pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: recordService

    property string status: "idle"      // states: "idle", "recording", "replay"
    property int elapsedSeconds: 0
    property int replayDuration: 60
    property bool recordAudio: true

    property string scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/screen_record/"

    Timer {
        id: countTimer
        repeat: true
        interval: 1000
        onTriggered: parent.elapsedSeconds += 1
    }

    Process {
        id: startRecordProc
        command: ["sh", "-c", recordService.scriptPath + "start_recording.sh", recordService.recordAudio]
    }

    Process {
        id: stopRecordProc
        command: ["sh", "-c", recordService.scriptPath + "stop_recording.sh"]
    }

    Process {
        id: startReplayProc
        command: ["sh", "-c", recordService.scriptPath + "start_replay.sh", recordService.recordAudio]
    }

    Process {
        id: saveReplayProc
        command: ["sh", "-c", recordService.scriptPath + "save_replay.sh"]
    }

    function startRecording() {
        elapsedSeconds = 0;
        startRecordProc.startDetached();
        recordService.status = "recording";
        countTimer.start();
    }

    function stopRecording() {
        countTimer.stop();
        stopRecordProc.startDetached();
        recordService.status = "idle";
    }

    function startReplay() {
        elapsedSeconds = 0;
        startReplayProc.startDetached();
        recordService.status = "replay";
        countTimer.start();
    }

    function saveReplay() {
        saveReplayProc.startDetached();
    }

    function stopReplay() {
        stopRecordProc.startDetached();
        recordService.status = "idle";
    }
}
