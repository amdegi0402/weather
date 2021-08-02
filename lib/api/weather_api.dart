
import 'package:hello/function/convert_backgroun_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello/function/convert_time.dart';
import 'package:hello/function/convert_wind_deg.dart';
import 'package:hello/function/convert_weather_id.dart';
import 'package:hello/function/convert_icon.dart';
import 'package:hello/function/format_date.dart';

class CallWeatherData{

  callApi(String lat, String lon, [String elevation]) async {

    Map<String, dynamic> result; //天気データ
   
    //getメソッドでapi呼び出し
    final weatherRes = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&lang=ja&units=metric&exclude=daily&appid=625ba927222011bafd0d915b0e6cb5c2"));
    
    //取得したjsonデータをMap型に変換
    var weatherData = await jsonDecode(weatherRes.body);

    //utc時間表示を通常の時間表示に変換
    String sunriseTime = readTimestamp(weatherData["current"]["sunrise"]);
    String sunsetTime = readTimestamp(weatherData["current"]["sunset"]);

    //角度から風の方角を返す処理
    String windDeg = convertWindDeg(weatherData["current"]["wind_deg"]);

    //weatherIDを天気情報に変換する処理
    String weatherMain = convertWeatherId(weatherData["current"]["weather"][0]["id"].toString());
    //print("daily=> " + weatherData["daily"].toString());

    //背景画像ファイル名を返す処理
    String backgroundName = convertBackImage(weatherMain);
    
    //weatherアイコンに変換する処理
    String mainIcon = convertIcon(weatherMain);
    print("weather => " + weatherMain);

    //データから日付のみ返す
    String date = TimeData().getFormatDate(DateTime.now()).toString();
    //データから時間のみ返す
    String time = TimeData().getFormatTime(DateTime.now()).toString();
   
    
    //Map型に挿入して返り値として返す
    result = {
      "sunrise": sunriseTime,//日の出時間
      "sunset": sunsetTime,//日の入り時間
      "temp": weatherData["current"]["temp"].toString(),//温度
      "feels_like": weatherData["current"]["feels_like"].toString(),//体感温度
      "humibity": weatherData["current"]["humidity"].toString() + "%",//湿度
      //"uvi": weatherData["current"]["uvi"].toString(),//UV
      "clouds": weatherData["current"]["clouds"].toString() +"%",//雲の比率
      "wind_speed": weatherData["current"]["wind_speed"].toString() + "m/s",//風速
      "wind_deg": windDeg,//風向き
      "weatherMain": weatherMain,//天気メイン
      "backgroundImage": backgroundName,//背景画像ファイル名
      "main": weatherData["current"]["weather"][0]["main"].toString(),//天気
      //"icon": weatherData["current"]["weather"][0]["icon"],//アイコン
      "icon": mainIcon, //アイコン
      "elevation": elevation,//標高
      //"daily.feels_like.day": weatherData["daily"]
      "daily": "${date}" + " " + "${time}" //今日の日付
    };

    return result;
  
  }
}

