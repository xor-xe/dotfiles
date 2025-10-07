// SoundNotification.qml
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

Scope {
    property var screen: Quickshell.screens[0]
    property string volumeLevel: "0%"
    property bool isMuted: false
    
    // Process to monitor volume changes
    Process {
        id: volumeMonitor
        running: true
        command: ["wpctl", "subscribe"]
        
        stdout: SplitParser {
            onRead: data => {
                // When any audio event happens, update volume
                updateVolume()
            }
        }
    }
    
    // Function to get current volume
    function updateVolume() {
        volumeGetter.running = true
    }
    
    Process {
        id: volumeGetter
        running: false
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
        
        stdout: SplitParser {
            onRead: data => {
                // Parse output like "Volume: 0.50" or "Volume: 0.50 [MUTED]"
                let parts = data.trim().split(" ")
                if (parts.length >= 2) {
                    let vol = Math.round(parseFloat(parts[1]) * 100)
                    volumeLevel = vol + "%"
                    isMuted = data.includes("[MUTED]")
                    
                    // Show notification
                    notificationWindow.visible = true
                    hideTimer.restart()
                }
            }
        }
    }
    
    // Timer to auto-hide notification
    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: {
            notificationWindow.visible = false
        }
    }
    
    WlrLayershell {
        id: notificationWindow
        
        // Window properties
        implicitWidth: 200
        implicitHeight: 50
        visible: false  // Start hidden
        
        // Position at bottom center
        layer: WlrLayer.Overlay
        namespace: "sound-notification"
        keyboardFocus: WlrKeyboardFocus.None
        exclusiveZone: 0  // Don't reserve space - this is key!
        
        // Anchors for bottom center positioning
        anchors {
            bottom: true
            left: false
            right: false
        }

        margins {
            bottom: 20
        }
        
        // Background
        color: "transparent"
        
        // Rounded rectangle background
        Rectangle {
            anchors.fill: parent
            color: "#282828"
            radius: 20
            
            // Content
            Text {
                text: isMuted ? "🔇 Muted" : "🔊 " + volumeLevel
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
            }
        }
    }
}

