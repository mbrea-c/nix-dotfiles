pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    BatteryIcon {
        implicitHeight: root.implicitHeight
        implicitWidth: 25
        level: UPower.displayDevice.percentage
        charging: UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged
    }

    Text {
        text: `${100 * UPower.displayDevice.percentage}%`
    }
}
