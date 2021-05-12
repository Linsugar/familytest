import 'package:flutter/material.dart';
class homeState with ChangeNotifier {
String ?hometitle ="哈喽";
List homelist = [];
List reviewlist = [];

changereview(value){
  reviewlist.add(value);
  notifyListeners();
}

changelist(value){
  homelist.add(value);
  notifyListeners();
}
}