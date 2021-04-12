import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/chatmoled.dart';
class chatChild extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatChildState();
  }
}

class chatChildState extends State<chatChild>{
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';
  List<MapEntry<String,String>> _Streamlist= [];
  List<chatmodel> _chatlist= [];
  var _streamController = StreamController<String>();
  var _textcontroller = TextEditingController();
  var jso;
  final _web = IOWebSocketChannel.connect("ws://192.168.1.140:56788");

  @override
  void initState() {
    _web.sink.add("admin:123456");
    super.initState();
  }
  @override
  void dispose() {
    _streamController.close();
    _web.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("九尾妖狐"),actions: [CircleAvatar(backgroundImage: NetworkImage(_imagrurl)),SizedBox(width: 10,)],),
      body: Container(
          child:Flex(
            direction: Axis.vertical,
            children: [
              Expanded(flex: 8,child: StreamBuilder(
                stream: _web.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Icon(Icons.error);
                  }else{
                    _Streamlist.add(MapEntry("he", snapshot.data));
                    return ListView.builder(itemCount: _Streamlist.length,itemBuilder: (context,index){
                      if(_Streamlist[index].value !=null){
                        print("数据1：${snapshot.data}");
                        var s = jsonDecode(snapshot.data);
                        print("数据3：${s.name}");
                        if(_Streamlist[index].key =='he'){
                          return Hebuilder(Streamlist: _Streamlist, a: index, imagrurl: _imagrurl);
                        }
                        return Mebuilder(Streamlist: _Streamlist, a: index, imagrurl: _imagrurl);
                      }else{
                        return Align(alignment: Alignment.topCenter,child: Text("开始您的聊天之旅吧"),);
                      }
                    });
                  }
                },),),Flexible(flex: 1,child:Container(

                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.black
                        )
                    )
                ),
                child: Row(
                  children: [
                    Expanded(flex: 8,child: Container(padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        maxLines: 2,controller: _textcontroller,decoration: InputDecoration(
                        hintText: "请输入内容",
                        border: InputBorder.none,
                      ),),)),
                    Expanded(flex: 2,child: MaterialButton(color: Colors.blue,child: Text("发送"),onPressed: (){
                      if(_textcontroller.text.isEmpty){
                        Fluttertoast.showToast(msg: "你输入的内容为空");
                        return;
                      }
                      _web.sink.add('{"name":"张三"}');
                      _Streamlist.add(MapEntry("me", _textcontroller.text));
                      _textcontroller.clear();
                    },))
                  ],
                ),
              ),)
            ],
          )
      ),
    );
  }
}

class Mebuilder extends StatelessWidget {
  const Mebuilder({
    Key key,
    @required List<MapEntry<String, String>> Streamlist,
    @required this.a,
    @required String imagrurl,
  }) : _Streamlist = Streamlist, _imagrurl = imagrurl, super(key: key);

  final List<MapEntry<String, String>> _Streamlist;
  final int a;
  final String _imagrurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          title: Align(alignment: Alignment.centerRight,child: Text("${_Streamlist[a].value}"),),
          trailing:CircleAvatar(backgroundImage: NetworkImage(_imagrurl),)
      ),
    );
  }
}
class Hebuilder extends StatelessWidget {
  const Hebuilder({
    Key key,
    @required List<MapEntry<String, String>> Streamlist,
    @required this.a,
    @required String imagrurl,
  }) : _Streamlist = Streamlist, _imagrurl = imagrurl, super(key: key);

  final List<MapEntry<String, String>> _Streamlist;
  final int a;
  final String _imagrurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          title: Align(alignment: Alignment.centerLeft,child: Text("${_Streamlist[a].value}"),),
          leading:CircleAvatar(backgroundImage: NetworkImage(_imagrurl),)
      ),
    );
  }
}




