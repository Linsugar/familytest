
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:video_player/video_player.dart';
class videoWidget extends StatefulWidget {
  var value;
  videoWidget(this.value);
  @override
  _videoWidgetState createState() => _videoWidgetState();
}
class _videoWidgetState extends State<videoWidget> with WidgetsBindingObserver{
  String ?videoUrl;
  VideoPlayerController ?_videoPlayerController;
  TextEditingController ?_textEditingController;
  FocusNode _focusNode  =FocusNode();
  int focusIndex =0;
  int playState= 0;
  bool inputbool = false;
  bool emjstatue = true;
  var argumentValue;
  List<String>? _messagelist = [
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
    "哇，好牛逼","牛啊 牛啊 牛啊","帅爆了",
  ];
  @override
  void initState() {

    WidgetsBinding.instance!.addObserver(this);
    // TODO: implement initState
    argumentValue = widget.value['value'];
    videoUrl =argumentValue.videoUrl;
    _textEditingController =TextEditingController();
    _focusNode.addListener((){
      if (_focusNode.hasFocus) {
        print('得到焦点');

      }else{
        print('失去焦点');
      }
    });
    _videoPlayerController = VideoPlayerController.network(videoUrl!)
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
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      print("d当前结果：$focusIndex");
    });
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(argumentValue.videoTitle),),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _videoPlayerController!.value.isInitialized?AspectRatio(
              aspectRatio:focusIndex==0?_videoPlayerController!.value.aspectRatio:3.5/1,
              child: Stack(
                children: [
                  VideoPlayer(_videoPlayerController!),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: Row(children: [
                        InkWell(child: FaIcon(playState==0?FontAwesomeIcons.play:FontAwesomeIcons.stop,color: Colors.orangeAccent,),onTap: (){
                          setState(() {
                            if(playState==0){
                              playState = 1;
                              _videoPlayerController!.play();
                            }else{
                              playState=0;
                              _videoPlayerController!.pause();
                            }
                          });
                        },),
                      ],))
                ],
              ),):
            Center(child:Text("数据加载中")),
            Expanded(child: ListView.separated(itemBuilder: (context,index){
              return Text("${_messagelist![index]}");
            }, separatorBuilder: (context,index){
              return Divider();
            }, itemCount: _messagelist!.length)),
            Container(color: Colors.orange,
              child: Row(
                children: [
                  Expanded(
                      flex: 7,child: Container(
                      child: TextField(
                        onChanged: (value){
                          if(value.isEmpty){
                            setState(() {
                              inputbool = false;
                            });
                          }else{
                            setState(() {
                              inputbool = true;
                              emjstatue =true;
                            });
                          }
                        },
                        controller: _textEditingController,
                        minLines: 1,
                        maxLines: 2,decoration: InputDecoration(
                        isCollapsed: true,
                        hintText: "请输入您要发表的意见",
                        hintMaxLines: 20,
                        border: InputBorder.none,
                      ),)
                  )),
                  Expanded(
                      flex:3,child:Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                      Icon(Icons.add_circle),
                      inputbool?
                      Container(
                        width: 50,
                        child: Material(
                            borderRadius: BorderRadius.circular(5),

                            child:InkWell(
                              onTap: (){
                                if(_textEditingController!.text.isEmpty){
                                  PopupUntil.showToast("你输入的内容为空");
                                  return;
                                }
                                _messagelist!.add(_textEditingController!.text);
                                _textEditingController!.clear();
                                setState(() {
                                  inputbool =false;
                                  emjstatue =true;
                                });
                              },
                              child: Container(
                                child: Center(child: Text("发送")),
                              ),
                            )
                        ),
                      ): GestureDetector(onTap: (){
                        print("进去");
                        setState(() {
                          emjstatue =!emjstatue;
                        });
                      },child: FaIcon(FontAwesomeIcons.smileWink))
                    ],),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

