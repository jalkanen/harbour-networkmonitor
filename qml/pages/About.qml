import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: page
    Column {
        id: column
        spacing: 10

        height: page.height
        width :page.width

        Label {
            anchors.fill: parent

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text: "(C) Janne Jalkanen 2014.\n\nFor any suggestions, reports, etc.\njalkanen@ecyrd.com\n\nSource code on GitHub\nhttp://is.gd/7F6yP9\n\nIcon by ipapun\n(ipapun.deviantart.com)"
        }
    }
}
