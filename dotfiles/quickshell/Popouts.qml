import Quickshell
import QtQuick
import qs.services

PopupWindow {
    id: pop

    anchor.rect.x: Math.min(Screen.width - width, Math.max(0, PopoutConfig.xOffset - width / 2))
    anchor.rect.y: parentWindow.height

    width: 500
    height: 500

    readonly property real leftInner: Math.min(Screen.width - width, Math.max(0, PopoutConfig.xOffset - width / 2))

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
}
