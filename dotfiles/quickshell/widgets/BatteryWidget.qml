pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.components
import qs

RowLayout {
    id: root

    BatteryIcon {
        id: icon

        implicitHeight: root.implicitHeight
        implicitWidth: 25
        level: UPower.displayDevice.percentage
        charging: UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged

        MouseArea {
            anchors.fill: icon
            onClicked: {
                if (PopoutConfig.open) {
                    PopoutConfig.close();
                } else {
                    PopoutConfig.xOffset = icon.parentWindow.mapFromItem(root, mouseX, mouseY);
                    PopoutConfig.open();
                }
            }
        }
    }

    StyledText {
        text: `${100 * UPower.displayDevice.percentage}%`
    }
}
