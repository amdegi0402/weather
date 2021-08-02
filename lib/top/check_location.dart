import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/api/weather_api.dart';
import 'package:location/location.dart';
import 'package:hello/api/forecast_api.dart';

 
class FuncLocation extends ChangeNotifier{
  Future checkLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    var currentLocation;
    var weatherData;
    var subViewData;
   
  //端末の位置情報が許可されているか確認する処理
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return  false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    

    currentLocation = await location.getLocation();
    //現在地の経度緯度からメイン天気データ取得
    weatherData = await CallWeatherData().callApi(currentLocation.latitude.toString(), currentLocation.longitude.toString());
    //現在地の経度緯度からサブ天気データ取得
    subViewData = await CallForecastData().callApi(currentLocation.latitude.toString(), currentLocation.longitude.toString());

    //取得したデータをMapにセット
    Map<String, dynamic> resultData ={
      "mainData": weatherData,
      "subData": subViewData
    };

    return resultData;
    
  }
}