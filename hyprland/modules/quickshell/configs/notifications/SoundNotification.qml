// SoundNotification.qml
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

Scope {
    property var screen: Quickshell.screens[0]
    property int volumeLevel: 0
    property bool isMuted: false
    property int lastVolume: -1
    property bool lastMuted: false
    
    // Timer to poll volume changes
    Timer {
        id: volumePoller
        interval: 100  // Check every 100ms
        running: true
        repeat: true
        onTriggered: {
            volumeGetter.running = true
        }
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
                    let muted = data.includes("[MUTED]")
                    
                    // Check if volume or mute status changed
                    if (vol !== lastVolume || muted !== lastMuted) {
                        volumeLevel = vol
                        isMuted = muted
                        lastVolume = vol
                        lastMuted = muted
                        
                        // Show notification
                        notificationWindow.visible = true
                        hideTimer.restart()
                    }
                }
                volumeGetter.running = false
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
                text: isMuted ? "🔇 Muted" : "🔊 " + volumeLevel + "%"
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
            }
        }
    }
}

