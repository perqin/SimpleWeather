import QtQuick 2.3
import QtQuick.Controls 1.2
import "main.js" as Script
import "cities.js" as Data;

Item {
    id: page;
    width: parent.width;
    height: parent.height;
    focus: true;

    QtObject {
        id: internal;

        function initializeCombo(cityname) {
            for (var i = 0; i < Data.citiesList.length; i++)
                for (var j = 0; j < Data.citiesList[i].cities.length; j++)
                    if (Data.citiesList[i].cities[j] == cityname) {
                        /*provinceSelector.selectedIndex = i;
                        citySelector.model = Data.citiesList[i].cities;
                        citySelector.selectedIndex = j;*/
                        provinceCombo.currentIndex = i;
                        cityCombo.model = Data.citiesList[i].cities;
                        cityCombo.currentIndex = j;
                    }
        }
        function updateCitiesCombo(provinceindex) {
            /*citySelector.model = Data.citiesList[provinceindex].cities;
            citySelector.selectedIndex = 0;*/
            cityCombo.model = Data.citiesList[provinceindex].cities;
            cityCombo.currentIndex = 0;
        }
    }
    /*SelectScrollBox {
        id: provinceSelector;
        width: parent.width / 2;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top; anchors.bottom: parent.bottom;
        selecting: false; buttonTop: parent.height / 3;
        model: Data.citiesList; haveName: true;
    }
    SelectScrollBox {
        id: citySelector;
        width: parent.width / 2;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top; anchors.bottom: parent.bottom;
        selecting: false; buttonTop: provinceSelector.buttonTop + 400;
    }*/
    Image {
        id: backIcon;
        source: "backIcon.png";
        anchors.left: parent.left; anchors.top: parent.top;
        anchors.leftMargin: 50; anchors.topMargin: 50;
        MouseArea {
            anchors.fill: parent;
            onClicked: stackView.pop();
        }
    }

    Column {
        spacing: 200;
        anchors.centerIn: parent;

        ComboBox {
            id: provinceCombo;
            width: page.width / 2;
            model: Data.citiesList;
            textRole: "name";
            onCurrentIndexChanged: {
                console.log(Data.citiesList[currentIndex].name);
                internal.updateCitiesCombo(currentIndex);
            }
        }
        ComboBox {
            id: cityCombo;
            width: page.width / 2;
        }
        Image {
            id: okButton;
            source: "okIcon.png";
            anchors.horizontalCenter: parent.horizontalCenter;
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    stackView.pop();
                    settings.cityname = cityCombo.currentText;
                }
            }
        }
    }
    Keys.onBackPressed: {
        stackView.pop();
    }

    Component.onCompleted: internal.initializeCombo(settings.cityname);
}
