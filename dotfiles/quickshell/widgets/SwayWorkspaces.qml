pragma ComponentBehavior: Bound

import Quickshell.I3
import QtQuick
import QtQuick.Layouts
import qs.components

RowLayout {
    id: root

    required property string monitorName

    Repeater {
        model: I3.workspaces

        SwayWorkspace {
            required property var modelData

            workspace: modelData
            visible: modelData.monitor.name == root.monitorName
        }
    }
}
