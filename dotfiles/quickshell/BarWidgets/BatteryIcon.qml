import QtQuick

Item {
    id: battery
    property real level: 1.0         // 0.0 to 1.0
    property bool charging: false
    property color primaryColor: "black"
    property color fillColor: "lime"
    property color emptyColor: "transparent"
    readonly property int terminalDepth: 4
    readonly property int borderWidth: 2

    // Battery outline
    Rectangle {
        id: outline
        anchors.left: battery.left
        anchors.top: battery.top
        anchors.bottom: battery.bottom
        width: battery.width - battery.terminalDepth
        color: "transparent"
        border.color: battery.primaryColor
        border.width: battery.borderWidth
        radius: 3
    }

    // Battery “positive terminal”
    Rectangle {
        id: terminal
        width: battery.terminalDepth
        height: parent.height / 2
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: battery.primaryColor
        radius: 1
    }

    // Battery fill
    Rectangle {
        id: fill
        x: battery.borderWidth
        y: battery.borderWidth
        width: (parent.width - terminal.width - battery.borderWidth * 2) * Math.min(Math.max(battery.level, 0), 1)
        height: parent.height - 2 * battery.borderWidth
        z: -1
        color: battery.fillColor
        topLeftRadius: 2
        bottomLeftRadius: 2
        radius: 0
    }

    // Charging bolt overlay (optional)
    Canvas {
        id: bolt
        anchors.centerIn: outline
        width: outline.width - 2 * battery.borderWidth
        height: outline.height - 2 * battery.borderWidth
        visible: battery.charging

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.fillStyle = battery.primaryColor;

            var w = width;
            var h = height;

            // Draw plug body
            ctx.fillRect(0.3 * w, 0.1 * h, 0.4 * w, 0.8 * h);

            // Draw prongs
            ctx.fillRect(w * 0.7, 0.2 * h, w * 0.2, h * 0.2);
            ctx.fillRect(w * 0.7, 0.6 * h, w * 0.2, h * 0.2);

            // Draw cable
            ctx.fillRect(0, 0.4 * h, 0.3 * w, h * 0.2);
        }
    }
}
