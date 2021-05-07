import 'package:flutter/material.dart';

class taskState extends ChangeNotifier{

List tasklist = [];

changeTask(value){
  tasklist.clear();
  tasklist = value;
  notifyListeners();
}


}