import Quickshell // for PanelWindow
import Quickshell.Io // for Porcess
import QtQuick // for Text

Scope{
  id:root 

  // used to display the time, and change it when the process is run
  property string time
// used so that component is created for each screen
Variants {
  model: Quickshell.screens;  // used to change the color of the text
  
  delegate: Component {
    PanelWindow {
      // the screen from the screens list will be injected into this
      // property
      required property var modelData

      // we can then set the window's screen to the injected property
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30
      color: "black"

      Text {
        id: clock // like html id to refer it

        // center the bar in its parent component (the window)
        anchors.centerIn: parent
        color: "white"
        text: root.time
    
      }
    }
  }
}

Process {
  id: dateProc
  // the command it will run, every argument is its own string
  command: ["date"]

  // run the command immediately
  running: true

  // process the stdout stream using a StdioCollector
  // Use StdioCollector to retrieve the text the process sends
  // to stdout.
  stdout: StdioCollector {
    // Listen for the streamFinished signal, which is sent
    // when the process closes stdout or exits.
    onStreamFinished: root.time = this.text // `this` can be omitted
  }
}

//used to return process at certain interval
Timer {
  // 1000 milliseconds is 1 second
  interval: 1000
  // start the timer immediately
  running: true
  //run timer when it ends
  repeat: true
  // when the timer is triggered, set the running property of the
  // process to true, which reruns it if stopped.
  onTriggered: dateProc.running = true
}

}