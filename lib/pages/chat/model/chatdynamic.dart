import 'dart:convert';

class chatdynamic{
  String ?username;
  String ?avator;
  String ?title;
  String ?con;
  List ?imagelist = [];
  String ?time;
  int? dyid;
  chatdynamic(value){
    print("id多少：${value['id']}");
    this.username = value['Up_name'];
    this.dyid = value['id'];
    this.avator = value['Up_avator'];
    this.title = value['Up_Title'];
    this.con = value['Up_Context'];
    var k = value["Up_ImageUrl"];
    var jsonimage = jsonDecode(k);
    this.imagelist = jsonimage;
    this.time = value['Up_Time'];
  }

}