pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.widgets

Variants {
    model: Quickshell.screens

    Bar {
        id: bar

        required property var modelData

        screen: modelData
        spacing: 13

        leftWidgets: [
            Component {
                SwayWorkspaces {
                    monitorName: bar.screen.name
                }
            }
        ]

        centerWidgets: [
            Component {
                ClockWidget {}
            }
        ]

        rightWidgets: [
            Component {
                PowerProfilesWidget {}
            },
            Component {
                BatteryWidget {}
            },
            Component {
                Tray {
                    parentWindow: bar.panelWindow
                }
            }
        ]
    }
}
