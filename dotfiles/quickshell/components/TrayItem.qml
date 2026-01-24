pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

Rectangle {
    id: root

    implicitHeight: 20
    implicitWidth: 20
    color: "transparent"

    required property SystemTrayItem item
    required property QsWindow parentWindow

    IconImage {
        anchors.centerIn: root

        implicitSize: root.implicitHeight
        source: root.item.icon
    }

    MouseArea {
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        onClicked: root.item.activate()
    }

    MouseArea {
        acceptedButtons: Qt.MiddleButton
        anchors.fill: parent
        onClicked: root.item.secondaryActivate()
    }

    MouseArea {
        acceptedButtons: Qt.RightButton
        anchors.fill: parent
        onClicked: {
            const pos = root.parentWindow.mapFromItem(root, mouseX, mouseY)
            root.item.display(root.parentWindow, pos.x, pos.y);
        }
    }
}
