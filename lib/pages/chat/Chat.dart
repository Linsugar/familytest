import 'package:flutter/material.dart';
import 'package:familytest/roog/roogYun.dart';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Chatstate();
  }
}

class Chatstate extends State<Chat>  with SingleTickerProviderStateMixin{
  AnimationController ?_Amc;
  String _headerimag = 'http://qr0n4nltx.hn-bkt.clouddn.com/p3.jpg';

  @override
  void initState() {
    _Amc = AnimationController(vsync: this,duration: Duration(seconds: 300));
    Roogyun.rooglistn(context);
    super.initState();
  }

  @override
  void dispose() {
    _Amc?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("畅聊"), actions: [
          PopuWidget()
        ],),
        body: SingleChildScrollView(
          child: Container(padding: EdgeInsets.only(top: 10),width: _size.width,height: _size.height,
            child: FutureBuilder(
              future: Roogyun.getallConversation(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                print("加载状态：${snapshot.data}");
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }if(snapshot.hasError){
                  return Center(child: Text("数据有误"));
                }else{
                  return Column(
                    children: [
                      Expanded(flex: 1,child: ListTile(
                        key: UniqueKey(),
                        subtitle: Text("在这里可以与许多不同的朋友一起畅聊生活琐事",overflow: TextOverflow.ellipsis,maxLines: 1,),
                        leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(_headerimag),),title: Text("聊天广场"),trailing: MaterialButton(onPressed: (){
                         print("点击");
                         _Amc?.forward();
                         Navigator.pushNamed(context,'/chatChild',arguments:{
                         'userinfo': snapshot.data
                         });
                      },child: Icon(Icons.pan_tool,color: Colors.cyan,)),)),
                      Expanded(flex:8,child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            key: UniqueKey(),
                            subtitle: Text("${snapshot.data[index].user_context}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                            leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(snapshot.data[index].avator_image),),title: Text(snapshot.data[index].name),trailing: MaterialButton(onPressed: (){
                              print("点击$index");
                              _Amc?.forward();
                              Navigator.pushNamed(context,'/chatChild',arguments:{
                                'userinfo': snapshot.data[index]
                              });
                              },child: Icon(Icons.tab)),);
                        },separatorBuilder: (context,index){
                        return Divider();
                      },))
                    ],
                  );
                }
              },
            ),),
        )
    );
  }
}



class PopuWidget extends StatelessWidget {
  const PopuWidget({
    Key ?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.all(8),
        offset: Offset(0,5.0),
        onSelected: (value){
          print("选中的值:$value");
        },
        itemBuilder:(BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: '选项一的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.account_circle,color: Colors.lightBlue,),Text("添加好友")],)
          ),
          PopupMenuItem<String>(
              value: '选项二的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.search,color: Colors.lightBlue,),Text("搜索好友")],)

          )
        ]
    );
  }
}
