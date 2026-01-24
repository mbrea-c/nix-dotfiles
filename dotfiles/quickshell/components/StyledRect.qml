import QtQuick

Rectangle {
    id: root
    color: "transparent"

    Behavior on color {
        CAnim {}
    }

    Behavior on radius {
        Anim {}
    }

    Behavior on border.width {
        Anim {}
    }

    Behavior on border.color {
        CAnim {
            duration: 20
        }
    }
}
