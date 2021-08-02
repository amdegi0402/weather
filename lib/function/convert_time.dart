import "package:intl/intl.dart";
//import 'package:intl/date_symbol_data_local.dart';


//UTCタイムスタンプから時間を返す処理
String readTimestamp(int timestamp) {

  DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);//UTCタイムスタンプを見やすい形式に変換
  //DateTime time = DateTime.parse(times);
  var formatter = new DateFormat('HH:mm');//表示フォーマットを設定
  var formattedTime = formatter.format(time); // 値をフォーマットする
  
  return formattedTime.toString();
}

//UTCタイムスタンプから日付を返す処理
String readDatestamp(int timestamp) {

  DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);//UTCタイムスタンプを見やすい形式に変換
  //DateTime time = DateTime.parse(times);
  var formatter = new DateFormat('M/d');//表示フォーマットを設定
  var formattedDate = formatter.format(time); // 値をフォーマットする
  
  return formattedDate.toString();
}