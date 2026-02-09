pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config

Scope {
    id: root

    required property ShellScreen screen

    property var spacing: 8
    property var leftMargin: 8
    property var rightMargin: 8

    property list<Component> leftWidgets: []
    property list<Component> centerWidgets: []
    property list<Component> rightWidgets: []

    readonly property alias panelWindow: barPanel

    PanelWindow {
        id: barPanel
        screen: root.screen

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 30

        Rectangle {
            id: barRectangle

            anchors.fill: parent
            color: Colours.palette.m3surface

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: root.leftMargin
                anchors.rightMargin: root.rightMargin
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
                    spacing: root.spacing
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

            Canvas {
                id: bolt
                anchors.fill: barRectangle

                onPaint: {
                    let ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.fillStyle = Colours.palette.m3outline;

                    let w = width;
                    let h = height;

                    let lineWidth = Appearance.border.thickness;

                    // Draw plug body
                    ctx.fillRect(0, h - lineWidth, w, h);
                }
            }
        }

        // Popouts {
        //     id: barPopout
        //     anchor.window: barPanel
        // }
    }
}
