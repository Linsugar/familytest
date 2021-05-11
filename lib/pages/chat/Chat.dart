import 'package:familytest/network/requests.dart';
import 'package:familytest/pages/chat/model/chatdynamic.dart';
import 'package:familytest/pages/home/model.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize:  Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                isScrollable: false,
                tabs: [
                  Text("聊天",style: TextStyle(fontSize: 20),),
                  Text("动态",style: TextStyle(fontSize: 20)),
                ],),),
          ),
          body:TabBarView(
            children: [
              chatabout(size: _size, headerimag: _headerimag, Amc: _Amc),
              dya()
            ],
          )
      ),
    );
  }
}

//聊天
class chatabout extends StatelessWidget {
  const chatabout({
    Key? key,
    required Size size,
    required String headerimag,
    required AnimationController? Amc,
  }) : _size = size, _headerimag = headerimag, _Amc = Amc, super(key: key);

  final Size _size;
  final String _headerimag;
  final AnimationController? _Amc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(padding: EdgeInsets.only(top: 10),width: _size.width,height: _size.height,
        child: Column(
          children: [
            header(),
            Expanded(
              child: FutureBuilder(
                future: Roogyun.getallConversation(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  print("加载状态：${snapshot.data}");
                  if(snapshot.connectionState ==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }if(snapshot.hasError){
                    return Center(child: Text("您当前还未与其他人有过聊天哦~"));
                  }
                  else{
                    return Column(
                      children: [
                        Expanded(flex: 1,child: ListTile(
                          key: UniqueKey(),
                          subtitle: Text("在这里可以与许多不同的朋友一起畅聊生活琐事",overflow: TextOverflow.ellipsis,maxLines: 1,),
                          leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(_headerimag),),
                          title: Text("聊天广场"),trailing: MaterialButton(
                            onPressed: (){
//                    print("点击");
//                    _Amc?.forward();
//                    Navigator.pushNamed(context,'/chatChild',arguments:{
//                      'userinfo': snapshot.data
//                    });
                              PopupUntil.showToast("当前功能正在开发中~");
                            },child: Icon(Icons.pan_tool,color: Colors.cyan,)),)),
                        Expanded(flex:8,child: ListView.separated(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              key: UniqueKey(),
                              subtitle: Text("${snapshot.data[index].user_context}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].avator_image),),
                              title: Text(snapshot.data[index].name),trailing: MaterialButton(onPressed: (){
                              print("点击$index");
                              _Amc?.forward();
                              Navigator.pushNamed(context,'/chatChild',arguments:{
                                'userinfo': snapshot.data[index]
                              });
                            },child: FaIcon(FontAwesomeIcons.commentDots)),);
                          },separatorBuilder: (context,index){
                          return Divider();
                        },))
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),),
    );
  }
}


//动态页

class dya extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    _getdynamic()async{
      List<chatdynamic> dylist = [];
      var result = await Request.getNetwork('dynamicall/',params: {
        'user_id':context.read<GlobalState>().userid
      },token:context.read<GlobalState>().logintoken);
      result.forEach((value){
        dylist.add( chatdynamic(value));
      });
      return dylist;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      child:FutureBuilder(
        future: _getdynamic(),
        builder:(BuildContext context, AsyncSnapshot snapshot){
          print("动态：${snapshot.data}");
          if(snapshot.hasError){
            return Icon(Icons.error);
          }if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }if(snapshot.data.isEmpty){
            return Center(child: Text("目前还未有动态发布"),);
          }
          else{
            return Container(child: ListView.separated(
                itemBuilder: (context,index){
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].avator),),
                        title: Text("${snapshot.data[index].title}"),
                        subtitle:  Text("发布时间:${snapshot.data[index].time}"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        constraints: BoxConstraints(
                          maxHeight: 100,
                          minHeight: 10,
                        ),
                        child:  Text("${snapshot.data[index].con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
                      ),
                      SizedBox(height: 10),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: 100,
                        ),
                        child:Column(
                          children: [
                            Expanded(flex: 3,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,im){
                                    return Container(
                                      margin: EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data[index].imagelist[im]),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                      width: 80,
                                    );
                                  }, separatorBuilder: (context,im){
                                return SizedBox(width: 5,height: 5,);
                              }, itemCount: snapshot.data[index].imagelist.length),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                MaterialButton(child: Text("点赞"),onPressed: (){}),
                                MaterialButton(child: Text("评论"),onPressed: (){
                                  Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':snapshot.data[index]} );
                                }),
                              ],),
                            ),
                          ],
                        ) ,
                      )
                    ],
                  );
                }, separatorBuilder: (context,index){
              return  Divider();
            }, itemCount: snapshot.data.length));
          }
        },),
    );;
  }
}




class header extends StatelessWidget {
  const header({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var spdate =context.watch<GlobalState>().overuser;
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),child:
    ListView.separated(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context,'/chatChild',arguments:{
            "userinfo":spdate![index]
          });
        },
        child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2.0),shape:BoxShape.circle ,
            boxShadow: [BoxShadow(color: Colors.blue,offset: Offset(0.0,1.0))],image: DecorationImage(image: NetworkImage(spdate![index].avator_image),fit: BoxFit.cover)
        )),
      );
    },itemCount: spdate!.length,separatorBuilder: (context,index){
      return SizedBox(width: 10,);
    },)
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


