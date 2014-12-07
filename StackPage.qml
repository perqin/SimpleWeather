import QtQuick 2.3
import QtQuick.Controls 1.2

Item {
    signal settingsTriggered();

    MenuBar {
        Menu {
            title: qsTr("More");
            MenuItem {
                text: qsTr("Settings");
                onTriggered: settingsTriggered();
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
}
