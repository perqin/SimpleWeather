import QtQuick 2.3

Rectangle {
    id: background;
    //anchors.fill: parent;
    gradient: Gradient {
        GradientStop {
            position: 0.0;
            color: "#0000A0";
        }
        GradientStop {
            position: 1.0;
            color: "#8080FF";
        }
    }
}
