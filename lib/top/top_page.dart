import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:hello/top/check_location.dart';
import 'package:hello/main.dart';


class TopPage extends StatelessWidget{
  
  //現在地の経度と緯度を取得後天気情報を取得
  Future listData()async {
    final result = await FuncLocation().checkLocation();
    print("1 " + result["mainData"]["weatherMain"].toString());
    return result["mainData"]["weatherMain"].toString();
  }

  //カウンター
  bool refresh = false;

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text('YAMA TENKI'),
        centerTitle: true,
      ),
      drawer: Drawer(
         child: ListView(
            children: <Widget>[
              /*
              DrawerHeader(
                child: Text(
                  'My App',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              */
              ListTile(
                title: Text('LOGOUT'),
                onTap: ()async{
                  await MyFirestore().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ]
          )
        ),

      body: Center(
        child: FutureBuilder(
          future: FuncLocation().checkLocation(),
          builder: (ctx,dataSnapshot){
            if(refresh == false){
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
            refresh = true;
            // 成功処理
            return Stack(
            children: <Widget>[
              SingleChildScrollView(
               
                child:Container(
                   padding: EdgeInsets.only(bottom: 50.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(listData["mainData"]["backgroundImage"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    child:Center(
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 70.0),),
                          Text(listData["mainData"]["daily"], style:TextStyle(fontSize: 40.0 ,fontWeight: FontWeight.w900)),
                          Text("現在地の天気", style:TextStyle(fontSize: 40.0 ,fontWeight: FontWeight.w900, 
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 2.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ],
                          )
                          ),
                          Padding(padding: const EdgeInsets.only(top: 5.0),),
                          Image.asset('assets/' + listData["mainData"]["icon"], height: 100.0),
                          Text(listData["mainData"]["weatherMain"], style:TextStyle(fontSize: 40.0)),
                          Text(
                            "気温 　　　　" + listData["mainData"]["temp"] + "℃" + "\n" +
                            "体感温度 　　" + listData["mainData"]["feels_like"] + "℃" + "\n" +
                            "湿度 　　　　" + listData["mainData"]["humibity"] + "\n" +
                            "雲の多さ 　　" + listData["mainData"]["clouds"] + "\n" +
                            "風向きと風速 " + listData["mainData"]["wind_deg"] + listData["mainData"]["wind_speed"] ,
                            style:TextStyle(fontSize: 20.0)
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0),),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => (TopPage()),
                                )
                              );
                            },
                            child: new Icon(Icons.refresh),
                          ),
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
                                      padding: const EdgeInsets.all(5.0),
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
           
            ]
          );
        }
          })
    )
    );
  }
}