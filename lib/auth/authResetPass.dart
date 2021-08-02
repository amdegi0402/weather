
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flushbar/flushbar.dart';
import 'package:hello/firestore/func_firestore.dart';
//import 'package:hello/top/top_page.dart';
import 'package:hello/main.dart';

class TextFieldNotifier extends ChangeNotifier{
  var emailInputController = TextEditingController(); //emailテキストエディットコントローラー
  //var passwordInputController = TextEditingController(); //passwordテキストエディットコントローラー
}

final incrementProvider = ChangeNotifierProvider((ref) => TextFieldNotifier()); //riverpod TextFieldNotifierクラスをセット

class SendResetPassPage extends StatelessWidget{

  void showFlush(BuildContext context){ //ログインエラーの場合に表示するflushbarメッセージ処理
     Flushbar(
        message: "送信に失敗しました",
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

                  //ログイン emailテキストフォーム
                  TextFormField(  
                    controller: context.read(incrementProvider).emailInputController, //riverpodクラスの変数へ挿入
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  Center(
                    child: ElevatedButton(
                      child: Text('送信'),
                      onPressed: () async {
                        final email = watch(incrementProvider).emailInputController.text; //riverpod emailInputControllerのテキスト参照
                        //final password =  watch(incrementProvider).passwordInputController.text; //riverpod passwordInputControllerのテキスト参照
                          
                        try {
                          // パスワード再設定メールを送信
                          MyFirestore().sendPasswordResetEmail(email);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => MyApp()), //データベースにユーザが存在していればトップページへ遷移
                          );
                        } catch (e) {
                          // 送信に失敗した場合
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