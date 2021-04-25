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

class wxinfo{
  String ?wxtitle;
  String ?wxtime;
  String ?wxurl;
  String ?wxphoto;
  wxinfo(value){
    this.wxtitle = value['wxtitle'];
    this.wxtime = value['wxtime'];
    this.wxurl = value['wxurl'];
    this.wxphoto = value['wximage'];
  }
}