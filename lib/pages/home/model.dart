class userinfomodel{
  String ?name;
  String ?userid;
  String ?avator_image;
  userinfomodel(value){
    name = value['username'];
    userid = value['user_id'];
    avator_image = value['avator_image'];
  }
}