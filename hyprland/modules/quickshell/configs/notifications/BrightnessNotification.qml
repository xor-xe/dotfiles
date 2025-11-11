// BrightnessNotification.qml
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

Scope {
    property var screen: Quickshell.screens[0]
    property int brightnessLevel: 0
    property int lastBrightness: -1
    property bool initialized: false
    
    // Timer to poll brightness changes
    Timer {
        id: brightnessPoller
        interval: 100  // Check every 100ms
        running: true
        repeat: true
        onTriggered: {
            brightnessGetter.running = true
        }
    }
    
    Process {
        id: brightnessGetter
        running: false
        command: ["sh", "-c", "echo $(( $(brightnessctl get) * 100 / $(brightnessctl max) ))"]
        
        stdout: SplitParser {
            onRead: data => {
                // Parse output: should be a single percentage number
                let brightness = parseInt(data.trim())
                
                if (!isNaN(brightness)) {
                    // Check if brightness changed
                    if (brightness !== lastBrightness) {
                        brightnessLevel = brightness
                        lastBrightness = brightness
                        
                        // Only show notification after first initialization
                        if (initialized) {
                            notificationWindow.visible = true
                            hideTimer.restart()
                        } else {
                            initialized = true
                        }
                    }
                }
                brightnessGetter.running = false
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
        namespace: "brightness-notification"
        keyboardFocus: WlrKeyboardFocus.None
        exclusiveZone: 0  // Don't reserve space
        
        // Anchors for bottom center positioning
        anchors {
            bottom: true
            left: false
            right: false
        }

        margins {
            bottom: 20  // Position above sound notification
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
                    text: "☀️"
                    color: "white"
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                // Brightness bar container
                Rectangle {
                    width: 120
                    height: 8
                    color: "#1a1a1a"
                    radius: 4
                    anchors.verticalCenter: parent.verticalCenter
                    
                    // Filled portion
                    Rectangle {
                        width: parent.width * (brightnessLevel / 100.0)
                        height: parent.height
                        color: "#ffffff"
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

