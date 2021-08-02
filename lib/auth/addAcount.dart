
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flushbar/flushbar.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:hello/top/top_page.dart';
import 'package:hello/main.dart';

class TextFieldNotifier extends ChangeNotifier{
  var emailInputController = TextEditingController(); //emailテキストエディットコントローラー
  var passwordInputController = TextEditingController(); //passwordテキストエディットコントローラー
  var userNameInputController = TextEditingController(); //usernameテキストエディットコントローラー
}

final incrementProvider = ChangeNotifierProvider((ref) => TextFieldNotifier()); //riverpod TextFieldNotifierクラスをセット

class AddAcountPage extends StatelessWidget{

  void showFlush(BuildContext context){ //ログインエラーの場合に表示するflushbarメッセージ処理
     Flushbar(
        message: "登録に失敗しました",
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);                         
  }

 @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.blueGrey[50],
      body:  Container(
          child: Center(
            child: Consumer(builder: (context, watch, child) {
            return Form(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),   
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),

                  //ログイン usernameテキストフォーム
                  TextFormField(  
                    controller: context.read(incrementProvider).userNameInputController, //riverpodクラスの変数へ挿入
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'UserName',
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  //ログイン emailテキストフォーム
                  TextFormField(  
                    controller: context.read(incrementProvider).emailInputController, //riverpodクラスの変数へ挿入
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  //ログイン passwordテキストフォーム
                  TextFormField(
                    controller: context.read(incrementProvider).passwordInputController, //riverpodクラスの変数へ挿入
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true, //PWを隠す
                  ),
                  const SizedBox(height: 24.0),

                  Center(
                    child: ElevatedButton(
                      child: Text('ユーザー登録'),
                      onPressed: () async {
                        final email = watch(incrementProvider).emailInputController.text; //riverpod emailInputControllerのテキスト参照
                        final password =  watch(incrementProvider).passwordInputController.text; //riverpod passwordInputControllerのテキスト参照
                        final userName = watch(incrementProvider).userNameInputController.text; //riverpod emailInputControllerのテキスト参照
                          
                        // ユーザー登録に成功した場合
                        try {
                          // メール/パスワードでユーザー登録
                          await MyFirestore().addAcount(email, password);
                          //ユーザ名をFirestoreに追加
                          //await MyFirestore().addData(userName, "testMountain");
                          
                          // トップ画面に遷移＋ログイン画面を破棄
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return MyApp();
                            }),
                          );
                        } catch (e) {
                          // ユーザー登録に失敗した場合
                          showFlush(context);
                        }
                      },
                    )
                  )
                ]
              )
            )
          );
        })
      )
    )
  );
  }
}