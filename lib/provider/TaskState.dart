import 'package:flutter/material.dart';

class taskState extends ChangeNotifier{

List tasklist = [];

changeTask(value){
  tasklist = value;
  notifyListeners();
}

clearTask(){
  tasklist.clear();
  notifyListeners();
}



}