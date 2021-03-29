import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  bool globalToken = true;
  List imageList = [];
//  改变token的值

  changToken(bool value){
    globalToken = value;
    notifyListeners();
  }
  changlist(value){
    imageList.add(value);
    notifyListeners();
  }
}