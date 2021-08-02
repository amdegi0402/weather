import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello/api/weather_api.dart';
import 'package:hello/api/forecast_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFirestore {

  //アカウント登録処理
  Future addAcount(String email, String password)async{
    // メール/パスワードでユーザー登録
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  
  //ログイン認証
  Future signIn(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await Firebase.initializeApp();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    }catch(e){
        
        return null;

    }
  }

  //ログインPWリセット
  Future sendPasswordResetEmail(String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } catch (error) {
      return error.code;
    }
  }

  //ログアウト
  Future signOut() async{
    await FirebaseAuth.instance.signOut();
  }
  
 //ドキュメントIDを指定してデータを追加
  addData(String userName, String mountName){
  FirebaseFirestore
  .instance.collection(userName).doc(mountName).set({
        "limitDay": DateTime.now() //追加した日時
    });
  }

  // コレクションIDとドキュメントIDを指定して取得
  getSelectData(String selectColection, String selectDoc) async{

    Map<String, dynamic> mainData; //メイン天気データ
    Map<String, dynamic> subData; //サブ天気データ

    await Firebase.initializeApp();
    final document = await FirebaseFirestore
    .instance
    .collection(selectColection)
    .doc(selectDoc)
    .get();

    Map<String, String> valueData = {
      'area': selectColection.toString(),
      'name' : selectDoc.toString(),
      'lat' : document['lat'].toString(),
      'lon' : document['lon'].toString(),
      'elevation' : document['elevation'].toString(),
    };

/*　関数呼び出し　*/ 
    //weather_apiクラス呼び出し
    mainData = await CallWeatherData().callApi(valueData['lat'], valueData['lon'], valueData['elevation']);
    //forecast_apiクラス呼び出し
    subData = await CallForecastData().callApi(valueData['lat'], valueData['lon']);
    //取得したデータをMapにセット
    Map<String, dynamic> resultData ={
      "mainData": mainData,
      "subData": subData
    };
/*　ここまで　*/

   
    return resultData;
  } 

//リストデータをfirestoreにセットする処理
  setDocData(List listData, int listLength)async{
    await Firebase.initializeApp();
    for(var i = 0; i <= listLength - 1; i++){
      String area = listData[i][4].toString();
      double elevation = listData[i][3];
      double lon = listData[i][2];
      double lat = listData[i][1];
      String mntName = listData[i][0];
      
      FirebaseFirestore.instance.collection(area).doc(mntName).set({
          "lat": lat, //経度
          "lon": lon, //緯度
          "elevation": elevation, //標高
          "addDatetime": DateTime.now() //登録日時
      });
    }
    
  }

  //ログインユーザーをチェック
  Future loginUserCheck() async{
    await Firebase.initializeApp(); 
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User _currentUser = _auth.currentUser;

    

    if (_currentUser != null) {
      final _user = _currentUser;
      print("login user $_user"); //ログイン中のユーザが存在している場合
      return 1;
    }else{
      print("no find user"); //ログイン中のユーザが存在していない場合
      return 0;
    }
  }
  

}
