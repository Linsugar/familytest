import 'package:flutter/material.dart';
class homeState with ChangeNotifier {
String ?hometitle ="哈喽";
List homelist = [];

changelist(value){
  homelist.add(value);
  notifyListeners();
}
}