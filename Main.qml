import QtQuick 6.5
import QtQuick.Controls 6.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("My Qt Android App")

    Rectangle {
        anchors.fill: parent
        color: "lightblue"

        Text {
            anchors.centerIn: parent
            text: "Hello Qt 6 Android!"
            font.pointSize: 24
        }
    }
}
