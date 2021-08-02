 import "package:intl/intl.dart";

class TimeData {

  //データからフォーマットした日付を返す処理
  String getFormatDate(DateTime timeData) {

    var formatter = new DateFormat('M/d');//表示フォーマットを設定
    var formattedTime = formatter.format(timeData); // 値をフォーマットする
    
    return formattedTime.toString();
  }

  //データからフォーマットした時間を返す処理
  String getFormatTime(DateTime timeData) {

    var formatter = new DateFormat('HH:mm');//表示フォーマットを設定
    var formattedTime = formatter.format(timeData); // 値をフォーマットする
    
    return formattedTime.toString();
  }
}
 