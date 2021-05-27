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


class VideoInfo{
  String ?videoCover;
  String ?videoTime;
  String ?videoUpUser;
  String ?videoUrl;
  String ?videoTitle;
  String ?videoContext;

  VideoInfo(value){
    this.videoTitle = value['video_Title'];
    this.videoContext = value['video_context'];
    this.videoUrl = value['video_url'];
    this.videoCover = value['video_cover'];
    this.videoTime = value['video_Time'];
    this.videoUpUser = value['video_upuserid'];
  }
}