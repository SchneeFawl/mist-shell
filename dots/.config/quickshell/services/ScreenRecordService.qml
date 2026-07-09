pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// qmllint disable unresolved-type

Singleton {
    id: recordService

    property string status: "idle"      // states: "idle", "recording", "replay"
    property int elapsedSeconds: 0

    property int replayDuration: 60
    property bool recordAudio: true
    property string quality: "very_high"
    property bool isReady: false

    property string scriptPath: Quickshell.env("HOME") + "/.config/mist/scripts/screen_record/"
    property string configPath: Quickshell.env("HOME") + "/.config/mist/screen_record.json"

    onReplayDurationChanged: writeConfig()
    onRecordAudioChanged: writeConfig()
    onQualityChanged: writeConfig()

    property FileView configFile: FileView {
        path: recordService.configPath
        watchChanges: true
        preload: true

        adapter: JsonAdapter {
            id: configAdapter
            property int replayDuration: 60
            property bool recordAudio: true
            property string quality: "very_high"
        }

        onLoadFailed: {
            recordService.configFile.adapter.replayDuration = recordService.replayDuration;
            recordService.configFile.adapter.recordAudio = recordService.recordAudio;
            recordService.configFile.adapter.quality = recordService.quality;
            Qt.callLater(recordService.configFile.writeAdapter);
            recordService.isReady = true;
        }

        onLoaded: {
            recordService.replayDuration = recordService.configFile.adapter.replayDuration;
            recordService.recordAudio = recordService.configFile.adapter.recordAudio;
            recordService.quality = recordService.configFile.adapter.quality;
            recordService.isReady = true;
        }
    }

    Component.onCompleted: configFile.reload()

    function writeConfig() {
        if (!isReady) return;
        configFile.adapter.replayDuration = replayDuration;
        configFile.adapter.recordAudio = recordAudio;
        configFile.adapter.quality = quality;
        configFile.writeAdapter();
    }

    Timer {
        id: countTimer
        repeat: true
        interval: 1000
        onTriggered: parent.elapsedSeconds += 1
    }

    Process {
        id: startRecordProc
        command: ["bash", recordService.scriptPath + "start_recording.sh", recordService.recordAudio, recordService.quality]
    }

    Process {
        id: stopRecordProc
        command: ["bash", recordService.scriptPath + "stop_recording.sh"]
    }

    Process {
        id: startReplayProc
        command: [
            "bash",
            recordService.scriptPath + "start_replay.sh",
            recordService.recordAudio ? "true" : "false",
            recordService.replayDuration.toString(),
            recordService.quality
        ]
    }

    Process {
        id: saveReplayProc
        command: ["bash", recordService.scriptPath + "save_replay.sh"]
    }

    Process {
        id: stopReplayProc
        command: ["bash", recordService.scriptPath + "stop_replay.sh"]
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
        stopReplayProc.startDetached();
        recordService.status = "idle";
    }
}
