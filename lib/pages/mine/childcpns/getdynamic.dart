import 'dart:convert';
class dynamicdata{
  String ?title;
  String ?context;
  List ?imageurl;
  String ?id;
  dynamicdata(value){
    this.title = value['Up_Title'];
    this.context = value['Up_Context'];
    this.imageurl = jsonDecode(value['Up_ImageUrl']);
    this.id = value['user_id'];
  }
}