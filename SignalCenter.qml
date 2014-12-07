import QtQuick 2.3

QtObject {
    id: signalCenter;

    signal citynameChanged(string cityname);
    signal cityidChanged(int cityid);
    signal weatherChanged;

    function showMessage(type, text) {
        if (text !== "") {
            console.log(text);
        }
    }
}
