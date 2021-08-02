import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/top/top_page.dart';
import 'package:hello/select_mount_data/select_page_top.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello/auth/auth.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:hello/test.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() => runApp( // ここ大事！
  ProviderScope(
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: MainPage(),
      //home: AuthPage(),
      home: FutureBuilder(
        future: MyFirestore().loginUserCheck(),
        builder: (ctx,dataSnapshot){
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
          final findUser = dataSnapshot.data.toString();
          return  findUser == "1" ? MainPage() : AuthPage();
        }
      ),
      /*
      routes: <String, WidgetBuilder> {
        '/toppage': (BuildContext context) => TopPage(),
        '/selectpage': (BuildContext context) => SelectPageTop(),
        '/test': (BuildContext context) => TestsPage()
      },
      */
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
             icon: Icon(CupertinoIcons.search),
                      label: '現在地',
          ),
          BottomNavigationBarItem(
             icon: Icon(CupertinoIcons.search),
                      label: 'セレクト',
          ),
          BottomNavigationBarItem(
             icon: Icon(CupertinoIcons.search),
                      label: 'お気に入り',
          ),
          
        ],
      ),
      tabBuilder: (context, index) {
         switch (index) {
          case 0: // 1番左のタブが選ばれた時の画面
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TopPage(), // 表示したい画面のWidget
              );
            });
          case 1: // ほぼ同じなので割愛
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SelectPageTop(), // 表示したい画面のWidget
              );
            });
          case 2: // ほぼ同じなので割愛
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TestsPage(), // 表示したい画面のWidget
              );
            });
        }
      }
    ); 
  }
}
