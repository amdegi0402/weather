
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello/function/convert_time.dart';
import 'package:hello/function/convert_subWeather_id.dart';
import 'package:hello/function/convert_subIcon.dart';

class CallForecastData{

  callApi(String lat, String lon) async {

    Map<String, dynamic> result; //天気データ
    List<String> listTime = [];
    List<String> listDate = [];
    List<String> listWeather = [];
    List<String> listIcon = [];
   
    //getメソッドでapi呼び出し
    final forecastRes = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&cnt=16&lang=ja&units=metric&exclude=daily&appid=625ba927222011bafd0d915b0e6cb5c2"));
    
    //取得したjsonデータをMap型に変換
    var forecastData = await jsonDecode(forecastRes.body);
   
    
    for(var i=0; i <= 15; i++){ //縦 0:時間 1:メイン天気id  
      listDate.add(readDatestamp(forecastData["list"][i]["dt"]).toString());
      listTime.add(readTimestamp(forecastData["list"][i]["dt"]).toString());
      listIcon.add(convertSubIcon(convertForecastId(forecastData["list"][i]["weather"][0]["id"].toString())));
      listWeather.add(convertForecastId(forecastData["list"][i]["weather"][0]["id"].toString()));
    }

    result = {
      "Date": listDate,
      "Time": listTime,
      "Icon": listIcon,
      "Weather": listWeather,
    };

    return result;
  }
}

