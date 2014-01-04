import QtQuick 2.1
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

        PageHeader {
            title: "Network bytes"
        }

        Rectangle {
            id: topper
            height: page.height*0.2
        }

        Grid {
            id: grid

            width: page.width
            spacing: Theme.paddingLarge
            columns: 3
            anchors.top: topper.bottom
            left: Theme.paddingLarge

            Label {
                text: "&nbsp;"
            }

            Label {
                text: "In"
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                text: "Out"
                font.pixelSize: Theme.fontSizeLarge
            }

            // WiFi
            Label {
                text: "WiFi"
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                id: wifiIn
                text: "..."
            }

            Label {
                id: wifiOut
                text: "..."
            }

            Label {
                text: "..."
            }

            Label {
                id: wifiInDiff
                text: "..."
            }

            Label {
                id: wifiOutDiff
                text: "..."
            }

            // Others

            Label {
                text: "Others"
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                id: oIn
                text: "..."
            }

            Label {
                id: oOut
                text: "..."
            }

            Label {
                text: "..."
            }

            Label {
                id: oInDiff
                text: "..."
            }

            Label {
                id: oOutDiff
                text: "..."
            }

            /*
           Label {
                id: labeloid
                //x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: {
                    Xhr.readBytes(function(inout){
                        labeloid.text = Xhr.formatString(inout);
                    });
                    return "...";
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeHuge
            }
            */
        }
        Timer {
            id: timer
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                Xhr.readBytes(function(inout){
                    var diff = Xhr.diff(inout);
                    wifiIn.text = Xhr.format(inout.wlanIn);
                    wifiOut.text = Xhr.format(inout.wlanOut);
                    wifiInDiff.text = Xhr.format(diff.wlanIn);
                    wifiOutDiff.text = Xhr.format(diff.wlanOut);
                    oIn.text = Xhr.format(inout.in);
                    oOut.text = Xhr.format(inout.out);
                    oInDiff.text = Xhr.format(diff.in);
                    oOutDiff.text = Xhr.format(diff.out);
                });
            }
        }
    }
}


