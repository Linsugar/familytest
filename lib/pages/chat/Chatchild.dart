import 'dart:async';
import 'package:familytest/provider/grobleState.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:familytest/roog/roogYun.dart';

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
  ScrollController _controller = ScrollController();
  bool inputbool = false;

  @override
  void initState() {
    userinfo = widget.arguments!['userinfo'];
    Roogyun.getConversation(userinfo.userid,context);
    getallmeg();
    getlistn();
    checkfoucde();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  checkfoucde(){
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        print("焦点");
      }else{
        print("失去焦点");
      }
    });
  }

  getallmeg()async{
    await Roogyun.roogHistoryMessages(userinfo.userid,context);
  }
  getlistn()async{
    await Roogyun.rooglistn(context);
  }

  @override
  Widget build(BuildContext context) {
    var hisy =context.watch<GlobalState>().historylist;
    return Scaffold(
      appBar: AppBar(title: Text(userinfo.name),actions: [CircleAvatar(backgroundImage: NetworkImage(userinfo.avator_image)),SizedBox(width: 10,)],),
      body:WillPopScope(
        onWillPop: ()async{
          print("拦截");
          Provider.of<GlobalState>(context,listen: false).clearhistory();
          return true;
        },
        child: Column(
          children: [
            Flexible(child:
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.separated(
                  controller: _controller,
                  itemBuilder: (context,index){
                    var Data = hisy![index];
                    return  hisy[index].senderUserId==userinfo.userid?talk1(Data: Data, userinfo: userinfo):talk2(Data: Data);
                  }, separatorBuilder: (context,index){
                return Divider();
              }, itemCount: hisy!.length),
            )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border:Border.all(color: Colors.blue,width: 1)
                ),
                child:Flex(
                  direction: Axis.horizontal,
                  children: [
                    FaIcon(FontAwesomeIcons.microphoneAlt),
                    SizedBox(width: 10,),
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
                              });
                            }
                          },
                          focusNode: focusNode,
                          controller: _textcontroller,
                          minLines: 1,
                          maxLines: 2,decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "请输入回答",
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
                              color: Colors.blue,
                              child:InkWell(
                                onTap: (){
                                  if(_textcontroller.text.isEmpty){
                                    Fluttertoast.showToast(msg: "你输入的内容为空");
                                    return;
                                  }
                                  print("当前输入内容：${_textcontroller.text},当前userid:${userinfo.userid}");
                                  Roogyun.sedMessage(_textcontroller.text,userinfo.userid,context);
                                  _textcontroller.clear();
                                },
                                child: Container(
                                  child: Center(child: Text("发送")),
                                ),
                              )
                          ),
                        ): FaIcon(FontAwesomeIcons.smileWink)
                      ],),
                    ))
                  ],
                ))
          ],
        ),
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
