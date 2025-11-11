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
    property bool initialized: false
    
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
                        
                        // Only show notification after first initialization
                        if (initialized) {
                            notificationWindow.visible = true
                            hideTimer.restart()
                        } else {
                            initialized = true
                        }
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
        screen: parent.screen
        
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
            
            Row {
                anchors.centerIn: parent
                spacing: 10
                
                // Icon
                Text {
                    text: isMuted ? "🔇" : "🔊"
                    color: "white"
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                // Volume bar container
                Rectangle {
                    width: 120
                    height: 8
                    color: "#1a1a1a"
                    radius: 4
                    anchors.verticalCenter: parent.verticalCenter
                    
                    // Filled portion
                    Rectangle {
                        width: parent.width * (volumeLevel / 100.0)
                        height: parent.height
                        color: isMuted ? "#666666" : "#ffffff"
                        radius: 4
                        
                        Behavior on width {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }
            }
        }
    }
}

