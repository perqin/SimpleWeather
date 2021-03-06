.pragma library

//Qt.include("cities.js");

var _signalCenter, _settings, provinces = new Array, citys = new Array(50);

function initialize(sc, s) {
    _signalCenter = sc;
    _settings = s;
}

function sendHttpRequest(method, url, data, onSucceed, onFail) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        switch (xhr.readyState) {
        case xhr.OPENED: break; //signalcenter.loadStarted();break;
        case xhr.HEADERS_RECEIVED:
            if (xhr.status != 200)
                onFail(qsTr("Connection Error with code ") + xhr.status + " : " + xhr.statusText);
            break;
        case xhr.DONE:
            if (xhr.status == 200) {
                try {
                    onSucceed(xhr.responseText);
                    //signalcenter.loadFinished();
                } catch (err) {
                    onFail(qsTr("Loading error."));
                }
            } else {
                onFail(qsTr("Error."));
            }
            break;
        }

    }
    if (method === "GET") {
        xhr.open("GET", url);
        xhr.send();
    }
    if (method === "POST") {
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-Length", data.length);
        xhr.send(data);
    }
}

function showError(error) {
    _signalCenter.showMessage("ERROR", error);
}

function getCityid(cityname) {
    var url = "http://apistore.baidu.com/microservice/cityinfo?cityname=" + cityname;
    //console.log(url);
    sendHttpRequest("GET", url, "", getCityidFromJSON, showError);
}

function getCityidFromJSON(json) {
    console.log("Cityid>>>");
    console.log(json);
    var obj = JSON.parse(json);
    if (obj.errNum == 0) {
        _settings.cityid = obj.retData.cityCode;
    } else {
        _signalCenter.occurError(obj.errMsg);
    }
}

function getWeather(cityid) {
    var url = "http://apistore.baidu.com/microservice/weather?cityid=" + cityid;
    //console.log(url);
    sendHttpRequest("GET", url, "", getWeatherFromJSON, showError);
}

function getWeatherFromJSON(json) {
    console.log("Weather>>>");
    console.log(json);
    var obj = JSON.parse(json);
    if (obj.errNum == 0) {
        _settings.date = obj.retData.date;
        _settings.time = obj.retData.time;
        _settings.weather = obj.retData.weather;
        _settings.temperature = obj.retData.temp;
        _settings.lowestTemperature = obj.retData.l_tmp;
        _settings.highestTemperature = obj.retData.h_tmp;
        _settings.windDirection = obj.retData.WD;
        _settings.windLevel = obj.retData.WS;
        _signalCenter.weatherChanged();
    } else {
        _signalCenter.occurError(obj.errMsg);
    }
}

function getWeatherIcon(weather) {
    if (weather == "多云转小雨")
        //return "wind_to_s_rain.png";
        return "rainy.png";
    else if (weather == "阴")
        return "overcast.png";
    else if (weather == "多云")
        return "cloudy.png";
    else if (weather == "阴转小雨")
        return "rainy.png";
    else if (weather == "晴")
        return "sunny.png";
    else if (weather == "小雪转多云")
        return "cloudy.png";
    else if (weather == "小雪")
        return "snowy.png";
    else if (weather == "大雪")
        return "snowy.png";
    else if (weather == "多云转晴")
        return "sunny.png";
    else if (weather == "小雨转阴")
        return "overcast.png";
    else if (weather == "")
        return ".png";
    else
        return "weather.png";
}
