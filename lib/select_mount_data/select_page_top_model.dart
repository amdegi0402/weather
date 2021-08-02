import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  String _selectedKey;
  String _selectedItem;
  bool _isVisible = false;

  void setColection(String value){
    _selectedKey = value;
    notifyListeners();
  }

  String getColection(){
    return _selectedKey;
  }

  void setDocument(String value){
    _selectedItem = value;
    notifyListeners();
  }

  String getDocument(){
    return _selectedItem;
  }

  void setVisible(bool value){
     _isVisible = value;
     notifyListeners();
  }
  bool getVisible(){
    return _isVisible;
  }



  
}