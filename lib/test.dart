import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/firestore/func_firestore.dart';
import 'package:hello/top/check_location.dart';
import 'package:hello/main.dart';
import 'package:hello/top/top_page.dart';


class TestsPage extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context){
   return Scaffold(
     body: Container(
       child: Center(
         child: ElevatedButton(
                    child: Text('firestore登録'),
                      onPressed: (){
                        MyFirestore().addData("akiras2","三代山");
                      },
                    )
       ) 
      )
    );
  }
}