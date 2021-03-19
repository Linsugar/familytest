import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  bool globalToken = true;
//  改变token的值

  changToken(bool value){
    globalToken = value;
    notifyListeners();
  }
}