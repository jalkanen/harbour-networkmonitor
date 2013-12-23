import QtQuick 2.0
import Sailfish.Silica 1.0
import "Xhr.js" as Xhr

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: {
                    pageStack.push("About.qml");
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            height: page.height
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Network bytes"
            }
            Label {
                id: labeloid
                //x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                text: {
                    Xhr.readBytes(function(inout){
                        labeloid.text = Xhr.formatString(inout);
                    });
                    return "...";
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeHuge
            }
        }
        Timer {
            id: timer
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                Xhr.readBytes(function(inout){
                    labeloid.text = Xhr.formatString(inout);
                });
            }
        }
    }
}


