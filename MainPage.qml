import QtQuick 2.3
import "main.js" as Script

Item {
    QtObject {
        id: internal;

        function updateInformation() {
            timeLabel.text = qsTr("Updated at ") + settings.time + " " + settings.date;
            weatherLabel.text = settings.weather;
            temperatureLabel.text = settings.temperature + qsTr("\u2103");
            /*lowestTemperatureLabel.text = settings.lowestTemperature;
            highestTemperatureLabel.text = settings.highestTemperature;*/
            lowestTemperatureLabel.text = settings.highestTemperature;
            highestTemperatureLabel.text = settings.lowestTemperature;
            windDirectionLabel.text = settings.windDirection;
            windLevelLabel.text = settings.windLevel;
            weatherImage.source = Script.getWeatherIcon(settings.weather);
        }
    }
    Text {
        id: pullUpdateLabel;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: -(50 + flickable.contentY);
        font.pixelSize: 36;
        color: "White";
        text: loading ? qsTr("Updating...") : flickable.contentY < -50 ? qsTr("Release to update") : qsTr("Pull to update");
    }
    Flickable {
        id: flickable;
        flickableDirection: Flickable.VerticalFlick;
        anchors.fill: parent;
        Item {
            id: page;
            width: parent.width;
            height: parent.height;

            Image {
                id: placeButton;
                source: "placeIcon.png";
                anchors.left: parent.left; anchors.top: parent.top;
                anchors.leftMargin: 50; anchors.topMargin: 50;
                //width: 96; height: 96; fillMode: Image.Stretch;
                MouseArea {
                    anchors.fill: parent;
                    onClicked: stackView.push(Qt.resolvedUrl("PlaceSelectPage.qml"));
                }
            }
            Text {
                id: placeLabel;
                font.pixelSize: 72; color: "White";
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.top: parent.top; anchors.topMargin: 30;
                text: qsTr("Place");
            }
            Text {
                id: timeLabel;
                font.pixelSize: 36; color: "White";
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.top: placeLabel.bottom; anchors.topMargin: 6;
                text: qsTr("Time");
                Timer {
                    id: msgTimer;
                    interval: 3000;
                    repeat: false;
                    running: false;
                    triggeredOnStart: true;
                    onTriggered: {
                        if (errorMsg == "") {
                            timeLabel.text = tmp;
                            stop();
                        } else {
                            tmp = timeLabel.text;
                            timeLabel.text = errorMsg;
                            errorMsg = "";
                        }
                    }
                }
            }
            Image {
                id: quitButton;
                source: "quitIcon.png";
                anchors.right: parent.right; anchors.top: parent.top;
                anchors.rightMargin: 50; anchors.topMargin: 50;
                //width: 96; height: 96; fillMode: Image.Stretch;
                MouseArea {
                    anchors.fill: parent;
                    onClicked: Qt.quit();
                }
            }
            Item {
                id: weatherField;
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.top: parent.top; anchors.topMargin: 400;
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
                    anchors.right: divLine.left; anchors.rightMargin: 24;
                    text: qsTr("Cloudy");
                }
                Rectangle {
                    id: divLine;
                    width: 8; height: 72; color: "White";
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.top: parent.top; anchors.topMargin: 270;
                }
                Text {
                    id: temperatureLabel;
                    font.pixelSize: 96; color: "White";
                    anchors.verticalCenter: divLine.verticalCenter;
                    anchors.left: divLine.right; anchors.leftMargin: 24;
                    text: qsTr("23.5 *C");
                }
            }
            Column {
                spacing: 50;
                anchors.left: parent.left; anchors.leftMargin: 100;
                anchors.right: parent.right; anchors.rightMargin: 100;
                anchors.bottom: parent.bottom; anchors.bottomMargin: 50;
                Item {
                    width: parent.width; height: 300;
                    Image {
                        id: windIcon;
                        source: "windIcon.png";
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
                        source: "tempIcon.png";
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
                        color: "White";
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.left: parent.left; anchors.leftMargin: 500;
                        text: qsTr("~");
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
        }
        Connections {
            target: signalCenter;
            onCitynameChanged: {
                loading = true;
                timeLabel.text = qsTr("Updating...");
                Script.getCityid(cityname);
                placeLabel.text = cityname;
            }
            onCityidChanged: {
                timeLabel.text = qsTr("Updating...");
                loading = true;
                Script.getWeather(cityid);
            }
            onWeatherChanged: {
                loading = false;
                internal.updateInformation();
            }
            onOccurError: {
                loading = false;
                errorMsg = errMsg;
                msgTimer.start();
            }
        }
        onDragEnded: {
            if (!loading && contentY < -50) {
                loading = true;
                signalCenter.cityidChanged(settings.cityid);
            }
        }
    }

}
