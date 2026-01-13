import Quickshell
import QtQuick
import "BarWidgets" as Widgets

Scope {
    // Bar {
    //     spacing: 8

    //     leftWidgets: [
    //         Component {
    //             Text {
    //                 text: "test"
    //             }
    //         }
    //     ]
    //     centerWidgets: [
    //         Component {
    //             Widgets.ClockWidget {}
    //         }
    //     ]
    //     rightWidgets: [
    //         Component {
    //             Widgets.BatteryWidget {}
    //         }
    //     ]
    // }

    VolumeOsd {}
}
