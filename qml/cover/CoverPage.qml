import QtQuick 2.1
import Sailfish.Silica 1.0
import "../pages/Xhr.js" as Xhr

CoverBackground {
    property bool active: status == Cover.Active
    anchors.fill: parent

    Label {
        id: label
        anchors.centerIn: parent
        text: "..."
        font.pixelSize: Theme.fontSizeLarge
    }

    Timer {
        id: covertimer
        interval: 2000
        running: active
        repeat: true

        onTriggered: {
            Xhr.readBytes(function(inout){
                label.text = Xhr.formatString(inout);
            });
        }
    }

}


