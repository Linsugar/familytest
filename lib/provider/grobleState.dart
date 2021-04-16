import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  bool globalToken = false;
  List imageList = [];
  String city ='成都';
  String ?deviceid;
  String ?platform;
  var userid = '61122087048';
  String ?logintoken='';
  String ?avator = '';

  changeavator(value){
    avator =value;
    notifyListeners();
  }


  changuserid(value){
    userid ='$value';
    notifyListeners();
  }
  changlogintoken(value){
    logintoken ='ak7 '+value+ ' auth';
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