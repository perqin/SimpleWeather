import QtQuick 2.3
import QtQuick.Controls 1.2
import "main.js" as Script;

ApplicationWindow {
    id: app;
    visible: true;
    StackView {
        id: stackView;
        initialItem: mainPage;

        MainPage {
            id: mainPage;
        }
        SignalCenter {
            id: signalCenter;
        }
        Settings {
            id: settings;
        }

        Component.onCompleted: {
            Script.initialize(signalCenter, settings);
            settings.cityname = "北京";
        }

        /*SettingsPage {
            id: settingPage;
        }*/
    }
}
