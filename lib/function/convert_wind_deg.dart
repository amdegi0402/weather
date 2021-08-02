
//度数から風の方角を調べる処理
String convertWindDeg(int angles){
  //北: 337-23 北東: 24-66  東: 67-113 南東: 114-156 南: 157-203 西南: 204-246 西: 247-293 北西: 294-336
  String angle ="";
  int angleNum = angles;

  if(angleNum >= 337 || angleNum <= 23){
    angle = "北";
  }
  if(angleNum >= 24 && angleNum <= 66){
    angle = "北東";
  }
  if(angleNum >= 67 && angleNum <= 113){
    angle = "東";
  }
  if(angleNum >= 114 && angleNum <= 156){
    angle = "南東";
  }
  if(angleNum >= 157 && angleNum <= 203){
    angle = "南";
  }
  if(angleNum >= 204 && angleNum <= 246){
    angle = "南西";
  }
  if(angleNum >= 247 && angleNum <= 293){
    angle = "西";
  }
  if(angleNum >= 294 && angleNum <= 336){
    angle = "北西";
  }

  return angle;
}