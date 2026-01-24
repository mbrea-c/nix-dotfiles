pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.I3
import qs.components
import qs.services

StyledRect {
    id: root

    required property I3Workspace workspace

    width: 24
    height: 24
    radius: (workspace.active ? width / 2 : 2)

    color: "transparent"

    border.width: (workspace.active ? 3 : 1)
    border.color: workspace.focused ? Colours.palette.m3primary : Colours.palette.m3outline

    function selectWorkspace(n: int) {
        Quickshell.execDetached(["swaymsg", `workspace ${n}`]);
    }

    StyledText {
        anchors.centerIn: parent
        text: `${root.workspace.name}`
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.selectWorkspace(root.workspace.number)
    }
}
