
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
class videoWidget extends StatefulWidget {
  @override
  _videoWidgetState createState() => _videoWidgetState();
}

class _videoWidgetState extends State<videoWidget> {
  String ?videourl ="https://edge.ivideo.sina.com.cn/34446276003.mp4?KID=sina,viask&Expires=1618588800&ssig=3N%2FjgGgM1B&reqid=";
  VideoPlayerController ?_videoPlayerController;
  List<String>? _messagelist = [
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
  ];
  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.network(videourl!)
    ..initialize().then((value) => {
          setState(() {
            print("player初始化完成");
             })
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("实时新闻"),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _videoPlayerController!.play();
        },
        child: Text("点击"),),
      body: Container(
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("标题：叙利亚来访，中国军人勇武无敌",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18),),
            Expanded(flex: 5,child: _videoPlayerController!.value.isInitialized?AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,child: VideoPlayer(_videoPlayerController!),):
            Center(child:Text("数据加载中"))),
            Expanded(flex: 4,child: ListView.separated(itemBuilder: (context,index){
              return Text("${_messagelist![index]}");
            }, separatorBuilder: (context,index){
              return Divider();
            }, itemCount: _messagelist!.length)),
            Container(color: Colors.white,child: TextField(),)
          ],
        ),
      ),
    );
  }
}

