import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: page
    Column {
        id: column
        spacing: 10

        height: page.height
        width :page.width

        Text {
            anchors.fill: parent

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            color: Theme.primaryColor

            wrapMode: Text.WordWrap

            text: "<b>(C) Janne Jalkanen 2014.</b><br><br>For any suggestions, reports, etc.<br>
                   <a href=\"mailto:jalkanen@ecyrd.com\">jalkanen@ecyrd.com</a><br><br>
                   Source code available on<br><a href=\"http://is.gd/7F6yP9\">GitHub</a><br><br>
                   Icon by <a href=\"http://ipapun.deviantart.com/\">ipapun</a>"
        }
    }
}
