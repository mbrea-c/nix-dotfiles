pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components

RowLayout {
    id: root
    required property QsWindow parentWindow

    Repeater {
        model: SystemTray.items

        TrayItem {
            required property var modelData
            item: modelData
            parentWindow: root.parentWindow
        }
    }
}
