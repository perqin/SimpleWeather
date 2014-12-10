import QtQuick 2.3
import QtQuick.Controls 1.2
import "main.js" as Script;

ApplicationWindow {
    id: app;
    visible: true;
    property bool loading: false;
    property string errorMsg: "";
    property string tmp;

    Rectangle {
        id: background;
        width: parent.width;
        height: parent.height;
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
    StackView {
        id: stackView;
        initialItem: mainPage;
        anchors.fill: parent;

        MainPage {
            id: mainPage;
        }
        /*PlaceSelectPage {
            id: placeSelectPage;
        }*/

        SignalCenter {
            id: signalCenter;
        }
        Settings {
            id: settings;
        }
        Component.onCompleted: {
            Script.initialize(signalCenter, settings);
            settings.cityname = "广州";
        }
    }
}
