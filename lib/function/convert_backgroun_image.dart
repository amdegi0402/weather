//天気によって背景を変更する関数
//
String convertBackImage(String weatherName){
  String result;

  switch (weatherName) {
      case "雷雨":
        result = "assets/background/bk_flash.png";
        return result;
        //break;
      case "雷雨（強）":
        result = "assets/background/bk_flash.png";
        return result;
        //break;
      case "霧雨":
        result = "assets/background/bk_kiri.png";
        return result;
        //break;
      case "霧雨（強）":
        result = "assets/background/bk_kiri.png";
        return result;
        //break;
      case "雨":
        result = "assets/background/bk_rain.png";
        return result;
        //break;
      case "雨（強）":
        result = "assets/background/bk_rain.png";
        return result;
      case "雪":
        result = "assets/background/bk_snow.png";
        return result;
        //break;
      case "雪（強）":
        result = "assets/background/bk_snow.png";
        return result;
        //break;
      case "霧":
        result = "assets/background/bk_kiri.png";
        return result;
        //break;
      case "煙":
        result = "assets/background/bk_smoke.png";
        return result;
        //break;
      
      case "砂ほこり":
        result = "assets/background/bk_smoke.png";
        return result;
        //break;
      case "雨（強）":
        result = "assets/background/bk_rain.png";
        return result;
        //break;
      case "竜巻":
        result = "assets/background/bk_smoke.png";
        return result;
        //break;
      case "晴れ":
        result = "assets/background/bk_sun.png";
        return result;
        //break;
      case "晴れ時々曇り":
        result = "assets/background/bk_sun_cloud.png";
        return result;
        //break;
      case "曇り時々晴れ":
        result = "assets/background/bk_cloud_sun.png";
        return result;
        //break;
      case "曇り":
        result = "assets/background/bk_cloud.png";
        return result;
        //break;
    }
  }
