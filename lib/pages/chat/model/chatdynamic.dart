import 'dart:convert';

class chatdynamic{
  String ?username;
  String ?avator;
  String ?title;
  String ?con;
  List ?imagelist = [];
  String ?time;
  chatdynamic(value){
    this.username = value['Up_name'];
    this.avator = value['Up_avator'];
    this.title = value['Up_Title'];
    this.con = value['Up_Context'];
    var jsonimage = jsonDecode(value['Up_ImageUrl']);
    this.imagelist = jsonimage;
    this.time = value['Up_Time'];
  }

}