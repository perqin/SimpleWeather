import QtQuick 2.3
import "main.js" as Script

Rectangle {
    QtObject {
        id: internal;

        function updateInformation() {
            //date
            //time
            weatherLabel.text = settings.weather;
            temperatureLabel.text = settings.temperature;
            lowestTemperatureLabel.text = settings.lowestTemperature;
            highestTemperatureLabel.text = settings.highestTemperature;
            windDirectionLabel.text = settings.windDirection;
            windLevelLabel.text = settings.windLevel;
        }
    }

    anchors.fill: parent;
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

    Item {
        id: topBar;
        anchors.left: parent.left; anchors.leftMargin: 50;
        anchors.right: parent.right; anchors.rightMargin: 50;
        anchors.top: parent.top; anchors.topMargin: 50;
        height: 96;
        Image {
            id: placeButton;
            source: "placeIcon.png";
            anchors.left: parent.left; anchors.top: parent.top;
            //width: 96; height: 96; fillMode: Image.Stretch;
        }
        Text {
            id: placeLabel;
            font.pixelSize: 72; color: "White";
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top: parent.top; anchors.topMargin: 12;
            text: qsTr("Place");
        }
        Image {
            id: quitButton;
            source: "quitIcon.png";
            anchors.right: parent.right; anchors.top: parent.top;
            //width: 96; height: 96; fillMode: Image.Stretch;
            MouseArea {
                anchors.fill: parent;
                onClicked: Qt.quit();
            }
        }
    }
    Item {
        id: weatherField;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: topBar.bottom; anchors.topMargin: 200;
        width: 540; height: 400;
        Image {
            id: weatherImage;
            source: "quitIcon.png";
            anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top;
        }
        Text {
            id: weatherLabel;
            font.pixelSize: 96; color: "White";
            anchors.verticalCenter: divLine.verticalCenter;
            anchors.right: divLine.left; anchors.rightMargin: 12;
            text: qsTr("Cloudy");
        }
        Rectangle {
            id: divLine;
            width: 2; height: 72; color: "Grey";
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top: parent.top; anchors.topMargin: 270;
        }
        Text {
            id: temperatureLabel;
            font.pixelSize: 96; color: "White";
            anchors.verticalCenter: divLine.verticalCenter;
            anchors.left: divLine.right; anchors.leftMargin: 12;
            text: qsTr("23.5 *C");
        }
    }
    Column {
        spacing: 50;
        anchors.left: parent.left; anchors.leftMargin: 50;
        anchors.right: parent.right; anchors.rightMargin: 50;
        anchors.bottom: parent.bottom; anchors.bottomMargin: 50;
        Item {
            width: parent.width; height: 300;
            Image {
                id: windIcon;
                source: "quitIcon.png";
                anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter;
            }
            Text {
                id: windDirectionLabel;
                color: "White";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left; anchors.leftMargin: 300;
                text: qsTr("Wind Direction");
            }
            Text {
                id: windLevelLabel;
                color: "White";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left; anchors.leftMargin: 600;
                text: qsTr("Wind Level");
            }
        }
        Item {
            width: parent.width; height: 300;
            Image {
                id: temperatureIcon;
                source: "quitIcon.png";
                anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter;
            }
            Text {
                id: lowestTemperatureLabel;
                color: "White";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left; anchors.leftMargin: 300;
                text: qsTr("Lowest Temperature");
            }
            Text {
                id: highestTemperatureLabel;
                color: "White";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left; anchors.leftMargin: 600;
                text: qsTr("Highest Temperature");
            }
        }
    }
    Connections {
        target: signalCenter;
        onCitynameChanged: {
            Script.getCityid(cityname);
        }
        onCityidChanged: {
            Script.getWeather(cityid);
        }
        onWeatherChanged: {
            internal.updateInformation();
        }
    }
}
