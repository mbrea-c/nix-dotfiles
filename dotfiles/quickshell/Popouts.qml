import Quickshell
import QtQuick
import qs.services

PopupWindow {
    id: pop
    property bool open: true
    property real xOffset: 1250.0

    anchor.rect.x: Math.min(Screen.width - width, Math.max(0, xOffset - width / 2))
    anchor.rect.y: parentWindow.height

    width: 500
    height: 500

    visible: false

    color: "transparent"

    Behavior on height {
        NumberAnimation {
            duration: 220
            easing.type: Easing.OutCubic
        }
    }

    Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            bottomLeftRadius: 14
            bottomRightRadius: 14
            color: Colours.palette.m3surface
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            pop.open = !pop.open;
        }
    }
}
