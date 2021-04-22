import 'dart:async';
import 'package:familytest/provider/grobleState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

class chatChild extends StatefulWidget{
  Map ?arguments;
  chatChild(this.arguments);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatChildState();
  }
}

class chatChildState extends State<chatChild>{
  var _streamController = StreamController<String>();
  var _textcontroller = TextEditingController();
  var userinfo;
  List histortlist =[];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    userinfo = widget.arguments!['userinfo'];
    Roogyun.getConversation(userinfo.userid);
    RongIMClient.onMessageReceived = (Message msg,int left) {
      print("receive message messsageId:"+msg.messageId.toString()+" left:"+left.toString()+'msg:'+msg.toString());
      print("监听到消息：${msg.content.conversationDigest()}");
      print("消息发送者信息1：${msg.targetId}");
      print("消息发送者信息2：${msg.senderUserId}");
      setState(() {
        histortlist.add(msg);
      });
    };

    focusNode.addListener(() {
      if(focusNode.hasFocus){
        print("焦点");
      }else{
        print("失去焦点");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  getallmeg(String uid)async{
    histortlist =  await Roogyun.roogHistoryMessages(userinfo.userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userinfo.name),actions: [CircleAvatar(backgroundImage: NetworkImage(userinfo.avator_image)),SizedBox(width: 10,)],),
      body:Column(
          children: [
            Flexible(child:
            Container(
              width: double.infinity,
              height: double.infinity,
              child: FutureBuilder(
                future: getallmeg(userinfo.userid),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Icon(Icons.error);
                  }if(snapshot.connectionState ==ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else{
                    return Container(
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            var Data = histortlist[index];
                            return  histortlist[index].senderUserId==userinfo.userid?talk1(Data: Data, userinfo: userinfo):talk2(Data: Data);
                          }, separatorBuilder: (context,index){
                        return Divider();
                      }, itemCount: histortlist.length),
                    );
                  }
                },),
            )),
            Container(
                    width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                  border:Border.all(color: Colors.black,width: 1)
              ),
                  child:Flex(
                   direction: Axis.horizontal,
                    children: [
                    Expanded(
                        flex: 7,child: Container(
                      child: TextField(
                        focusNode: focusNode,
                      controller: _textcontroller,
                      minLines: 1,
                      maxLines: 2,decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: "请输入回答",
                      hintMaxLines: 20,
                      border: InputBorder.none,
                    ),),
                    )),
                    Expanded(
                      flex:2,child:Padding(
                        padding: EdgeInsets.all(5),
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                             color: Colors.blue,
                            child:InkWell(
                              onTap: (){
                                if(_textcontroller.text.isEmpty){
                                    Fluttertoast.showToast(msg: "你输入的内容为空");
                                    return;
                                    }
                                    setState(() {
                                    print("当前输入内容：${_textcontroller.text},当前userid:${userinfo.userid}");
                                    Roogyun.sedMessage(_textcontroller.text,userinfo.userid);
                                    _textcontroller.clear();
                                    });
                                    },
                              child: Container(
                                  child: Center(child: Text("发送")),
                          ),
                        )
                    ),
                  ))
                ],
            ))
          ],
        ),
    );
  }
}

class talk1 extends StatelessWidget {
  const talk1({
    Key? key,
    required this.Data,
    required this.userinfo,
  }) : super(key: key);

  final Data;
  final userinfo;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(userinfo.avator_image),),
//      title: Text("${Data.senderUserId}"),
      subtitle: Text("${Data.content.content}"),
    );
  }
}
class talk2 extends StatelessWidget {
  const talk2({
    Key? key,
    required this.Data,
  }) : super(key: key);
  final Data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text("${Data.content.content}",textAlign: TextAlign.right,style: TextStyle(),),
      trailing: CircleAvatar(backgroundImage: NetworkImage(context.watch<GlobalState>().avator!),),
    );
  }
}




//Row(
//children: [
//Container(
//width: 200,
//height: 30,
//child: TextField(
//style: TextStyle(fontSize: 25),
//maxLines: 2,controller: _textcontroller,decoration: InputDecoration(
//hintText: "请输入内容",
//border: InputBorder.none,
//),),
//),
//MaterialButton(color: Colors.blue,child: Text("发送"),onPressed: (){
//if(_textcontroller.text.isEmpty){
//Fluttertoast.showToast(msg: "你输入的内容为空");
//return;
//}
//setState(() {
//print("当前输入内容：${_textcontroller.text},当前userid:${userinfo.userid}");
//Roogyun.sedMessage(_textcontroller.text,userinfo.userid);
//_textcontroller.clear();
//});
//},
//)
//],
//)