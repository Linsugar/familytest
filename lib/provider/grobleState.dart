import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  bool globalToken = true;
  List imageList = [];
  String city ='成都';
  String deviceid;
  String platform;
  String userid;

  changuserid(value){
    userid =value;
    notifyListeners();
  }

  changdeviceid(value){
    deviceid = value;
    notifyListeners();
  }

  changplatform(value){
    platform = value;
    notifyListeners();
  }

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