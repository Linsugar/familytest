import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  List imageList = [];
  String city ='成都';
  String ?deviceid;
  String ?platform;
  var userid = '61122087048';
  String ?logintoken='';
  String ?avator;
  String ?roogtoken;
  List ?historylist= [];
  String ?username;
  List ?overuser = [];
  List ?emij = [];
  bool loadstatue =false;
  List wxlist = [];


  changewxlist(value){
    wxlist.add(value);
    notifyListeners();
  }

  changeloads(value){
    loadstatue = value;
    notifyListeners();
  }


  changeemij(value){
    emij!.add(value);
    notifyListeners();
  }

  changealluser(value){
    overuser!.add(value);
    notifyListeners();
  }


  changeusername(value){
    username = value;
    notifyListeners();
  }

  changhistory(value){
    historylist!.add(value);
    notifyListeners();
  }
  clearhistory(){
    historylist=[];
    notifyListeners();
  }

  changeavator(value){
    avator =value;
    notifyListeners();
  }

  changeroogtoken(value){
    roogtoken =value;
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

  changlist(value){
    imageList.add(value);
    notifyListeners();
  }
}