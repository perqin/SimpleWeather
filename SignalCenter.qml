import QtQuick 2.3

QtObject {
    id: signalCenter;

    signal citynameChanged(string cityname);
    signal cityidChanged(int cityid);
    signal weatherChanged;
    signal provincesPrepared;
    signal provinceChanged(int provinceid);
    signal occurError(string errMsg);

    function showMessage(type, text) {
        if (text !== "") {
            console.log(text);
        }
    }
}
