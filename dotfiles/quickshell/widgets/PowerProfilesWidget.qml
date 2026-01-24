import QtQuick
import Quickshell.Services.UPower
import Quickshell.Widgets
import qs.components
import qs.config

StyledRect {
    width: 25
    height: 25
    radius: Appearance.rounding.small
    color: {
        if (PowerProfiles.profile === PowerProfile.Performance) {
            return "red";
        } else if (PowerProfiles.profile === PowerProfile.Balanced) {
            return "blue";
        } else {
            return "green";
        }
    }

    IconImage {
        anchors.fill: parent
        source: {
            if (PowerProfiles.profile === PowerProfile.Performance) {
                return "root:/assets/icons/squat.svg";
            } else if (PowerProfiles.profile === PowerProfile.Balanced) {
                return "root:/assets/icons/scale.svg";
            } else {
                return "root:/assets/icons/leaves.svg";
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            {
                if (PowerProfiles.profile === PowerProfile.Performance) {
                    PowerProfiles.profile = PowerProfile.PowerSaver;
                } else if (PowerProfiles.profile === PowerProfile.Balanced) {
                    PowerProfiles.profile = PowerProfile.Performance;
                } else {
                    PowerProfiles.profile = PowerProfile.Balanced;
                }
            }
        }
    }
}
