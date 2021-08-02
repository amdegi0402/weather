
//import 'package:hello/auth/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello/auth/authResetPass.dart';
import 'package:hello/top/top_page.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:hello/auth/addAcount.dart';
import 'package:hello/main.dart';


class TextFieldNotifier extends ChangeNotifier{
  var emailInputController = TextEditingController(); //emailテキストエディットコントローラー
  var passwordInputController = TextEditingController(); //passwordテキストエディットコントローラー
}

final incrementProvider = ChangeNotifierProvider((ref) => TextFieldNotifier()); //riverpod TextFieldNotifierクラスをセット

//メイン　ユーザーAUTHクラス
class AuthPage extends StatelessWidget{
  
  void showFlush(BuildContext context){ //ログインエラーの場合に表示するflushbarメッセージ処理
     Flushbar(
        message: "IDもしくはPassWordが一致していません",
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
                        child: new ElevatedButton( //ログインボタン
                          child: const Text('Login'),   
                          onPressed: () async{
                            final email = watch(incrementProvider).emailInputController.text; //riverpod emailInputControllerのテキスト参照
                            final password =  watch(incrementProvider).passwordInputController.text; //riverpod passwordInputControllerのテキスト参照
                          
                            final result = await MyFirestore().signIn(email, password); //取得emailアドレスとパスを引数にサインイン関数で処理
                            if(result == null){
                              showFlush(context);//もしデータベースにユーザ情報が存在しなければエラーメッセージを返す
                            }else{
                              Navigator.of(context).pushReplacement(
                                //MaterialPageRoute(builder: (context) => TopPage()), //データベースにユーザが存在していればトップページへ遷移
                                MaterialPageRoute(builder: (context) => MyApp()),
                              );
                            }
                          },
                        ),
                      ),
                      
                      //パスワード不明
                      TextButton(
                        child: Text('パスワードが不明な場合'),
                        onPressed:(){   
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SendResetPassPage()), //データベースにユーザが存在していればトップページへ遷移
                          );
                        /*
                           Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ResetPassPage()),
                              );
                        */               
                        }
                      ),

                      TextButton(
                        child: Text('新規登録'),
                        onPressed:(){   
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAcountPage()),
                          );
                        }
                      ),

                      
                    ],
                  ),
                ),
              );
            }
          )
        )
      )
    );
  }
}