import QtQuick 2.3

QtObject {
    id: settings;

    property string cityname: "";
    onCitynameChanged: signalCenter.citynameChanged(cityname);

    property int cityid: 0;
    onCityidChanged: signalCenter.cityidChanged(cityid);

    property string date;
    property string time;
    property string weather;
    property string temperature;
    property string lowestTemperature;
    property string highestTemperature;
    property string windDirection;
    property string windLevel;

}
