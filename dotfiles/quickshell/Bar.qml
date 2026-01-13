pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "BarWidgets" as Widgets

Scope {
    id: root

    property var spacing: 8
    property list<Component> leftWidgets: []
    property list<Component> centerWidgets: []
    property list<Component> rightWidgets: []

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            RowLayout {
                anchors.fill: parent
                spacing: root.spacing

                // Left
                RowLayout {
                    spacing: root.spacing
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: implicitWidth

                    Repeater {
                        model: root.leftWidgets
                        delegate: Loader {
                            required property Component modelData
                            sourceComponent: modelData
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                // Right
                RowLayout {
                    spacing: 8
                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: implicitWidth

                    Repeater {
                        model: root.rightWidgets
                        delegate: Loader {
                            required property Component modelData
                            sourceComponent: modelData
                        }
                    }
                }
            }

            RowLayout {
                anchors.centerIn: parent
                spacing: root.spacing
                Layout.preferredWidth: implicitWidth

                Repeater {
                    model: root.centerWidgets
                    delegate: Loader {
                        required property Component modelData
                        sourceComponent: modelData
                    }
                }
            }
        }
    }
}
