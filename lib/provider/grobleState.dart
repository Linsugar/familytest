import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  List imageList = [];
  String city ='成都';
  String ?deviceid;
  String ?platform;
  String ?logintoken='';
  String ?roogtoken;
  List ?historylist= [];
  List ?overuser = [];
  List ?emij = [];
  bool loadstatue =false;
  List wxlist = [];
  List upImageList = [];
  String qiNiuToken ="";
  var userInfo;

  changeUserInfo(value){
    userInfo = value;
    notifyListeners();
  }

  changeQiNiu(value){
    qiNiuToken =value;
    notifyListeners();
  }

  changeUpImage(value){
    upImageList.add(value);
    notifyListeners();
  }


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


  changhistory(value){
    historylist!.add(value);
    notifyListeners();
  }
  clearhistory(){
    historylist=[];
    notifyListeners();
  }

  changeroogtoken(value){
    roogtoken =value;
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