pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property real xOffset: 500
    property bool isOpen: false

    function close() {
        root.open = false;
    }

    function open() {
        root.open = true;
    }
}
