
import 'package:flutter/material.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
//import 'package:hello/select_mount_data/select_page_model.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:riverpod/riverpod.dart';

// 1.グローバル変数にProviderを設定

  
class IncrmentNotifier extends ChangeNotifier{
  Widget icon = Icon(Icons.favorite);
  bool favorite = false;

  void increment(){
      
    if(favorite ==false){
      print("favorite_border");
      favorite = true;
    }else if(favorite ==true){
      print("favorite");
      favorite =false;
    }
    notifyListeners();
  }

  void showFavorite(bool favorite){
    if(favorite == false){
      icon = Icon(Icons.favorite);
    }else if(favorite ==true){
      icon = Icon(Icons.favorite_border);
    }
    notifyListeners();
  }
}

final incrementProvider = ChangeNotifierProvider((ref) => IncrmentNotifier());

class SelectPage extends StatelessWidget{
  final String selectColection; //県名
  final String selectDocument;  //山名


  //選択された県名と山名
  getFirestoreData(String selectColection, String selectDocument)async{
    var listData = await MyFirestore().getSelectData(selectColection, selectDocument);
    return listData;
  }
  
  SelectPage({Key key, @required this.selectColection, @required this.selectDocument}) : super(key: key);//main.dartから山名を受け取る
 

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size; //画面サイズを取得
    //var result = watch(resultProveider);

    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getFirestoreData(selectColection, selectDocument),
          builder: (ctx,dataSnapshot){
           // if(refresh == false){
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                // 非同期処理未完了 = 通信中
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (dataSnapshot.error != null) {
                // エラー
                return Center(
                  child: Text('エラーがおきました'),
                );
              }
              var listData = dataSnapshot.data;
             // refresh = true;
              // 成功処理
              return Stack(
              children: <Widget>[
                
                SingleChildScrollView(
                  child:Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(listData["mainData"]["backgroundImage"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:Container(
                      child:Center(
                        child: Column(
                          children: [
                           
                            
                            Padding(padding: const EdgeInsets.only(top: 50.0),),
                            Text(listData["mainData"]["daily"], style:TextStyle(fontSize: 40.0 ,fontWeight: FontWeight.w900)),
                            Text(selectDocument, style:TextStyle(fontSize: 40.0 ,fontWeight: FontWeight.w900, 
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 2.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ],)),
                            Padding(padding: const EdgeInsets.only(top: 5.0),),
                            Image.asset('assets/' + listData["mainData"]["icon"], height: 100.0),
                            Text(listData["mainData"]["weatherMain"], style:TextStyle(fontSize: 40.0)),
                            Text(
                              "標高 　　　　" + listData["mainData"]["elevation"] + "m" + "\n" +
                              "日の出 　" + listData["mainData"]["sunrise"] + "\n" +
                              "日の入 　" + listData["mainData"]["sunset"] + "\n" +
                              "気温 　　　　" + listData["mainData"]["temp"] + "℃" + "\n" +
                              "体感温度 　　" + listData["mainData"]["feels_like"] + "℃" + "\n" +
                            "湿度 　　　　" + listData["mainData"]["humibity"] + "\n" +
                            "雲の多さ 　　" + listData["mainData"]["clouds"] + "\n" +
                            "風向きと風速 " + listData["mainData"]["wind_deg"] + listData["mainData"]["wind_speed"] ,
                            style:TextStyle(fontSize: 20.0)
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0),),        
                   
                            SafeArea(
                              child: Container(
                                width:350.0,
                                height: 120.0,
                                child: ListView.builder(
                                  itemCount: listData["subData"]["Time"].length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) { 
                                    return Card(
                                      child: Padding(
                                        //padding: const EdgeInsets.all(5.0),
                                        padding: const EdgeInsets.only(bottom:5.0, left: 5.0, right: 5.0 ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[//サブ画面に表示するもの
                                            Text("${listData["subData"]["Date"][index]}"),
                                            Text("${listData["subData"]["Time"][index]}"),
                                            Image(// Imageウィジェット
                                              image: AssetImage("assets/" + "${listData["subData"]["Icon"][index]}"),// 表示したい画像
                                              height: 40.0,
                                            ),
                                            Text("${listData["subData"]["Weather"][index]}"),
                                            
                                          ]
                                        )
                                      )
                                    );
                                  }
                                )
                              )              
                            ),
                          ]
                        ) 
                      )
                    )             
                  )
                ),
                //お気に入りボタン
                //ProviderScope(
                  Container(
                    margin:EdgeInsets.only(top:30.0, left:size.width*(8/10)),
                    child: Consumer(builder: (context, watch, child) {
                      return FloatingActionButton(
                        backgroundColor: Colors.red[400],
                        onPressed: () {
                          context.read(incrementProvider).increment();
                          final icons = watch(incrementProvider).favorite;
                          context.read(incrementProvider).showFavorite(icons);
                        },
                        child: watch(incrementProvider).icon,
                      );
                    })
                  ),
                ]
            );
          }
        )
      )
    )
    );
  }
}

