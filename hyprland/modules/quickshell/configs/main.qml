// shell.qml
import Quickshell
import "./bar"
import "./notifications"

Scope {
  Bar {}
  SoundNotification {}
  BrightnessNotification {}
}