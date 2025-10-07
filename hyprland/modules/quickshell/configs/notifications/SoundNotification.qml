// SoundNotification.qml
import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    property var screen: Quickshell.screens[0]
    
    WlrLayershell {
        id: notificationWindow
        
        // Window properties
        width: 200
        height: 50
        visible: true
        
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
                text: "Sound Notification"
                color: "white"
                anchors.centerIn: parent
            }
        }
    }
}

