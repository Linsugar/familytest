
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class myui extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myuistate();
  }
}


class myuistate extends State<myui>{
  initState(){
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _state = context.watch<GlobalState>();
    var _size= MediaQuery.of(context).size;
    return Scaffold(
      drawer: Container(
        width: _size.width/2+20,
        child: MediaQuery.removePadding(context: context,
            removeTop: true,
            child: Drawer(
              child:Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 6,
                                child: ClipOval(
                                  child: Container(
                                    width:100,
                                    height:100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(_state.avator!),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:4,
                                child: MaterialButton(child: Text("登出"),onPressed: (){
                                  Navigator.pushReplacementNamed(context, "/MyHomePage");
                                },),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.search),
                        SizedBox(width: 10,),
                      Text("换肤")
              ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        FaIcon(FontAwesomeIcons.search),
                        SizedBox(width: 10,),
                        Text("换肤")
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        FaIcon(FontAwesomeIcons.search),
                        SizedBox(width: 10,),
                        Text("切换语言")
                      ],),

            ],
          ),
        )),
      ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(icon: Icon(Icons.settings),
                    onPressed: (){
                      Navigator.pushNamed(context, '/mysetting');
                    })],
              flexibleSpace: FlexibleSpaceBar(
                  background:Image.network(context.watch<GlobalState>().avator!,fit: BoxFit.cover,)
              ),
              expandedHeight: 150,
            ),
            SliverToBoxAdapter(
              child: Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(0.0, 0.0),spreadRadius: 1.0,blurRadius: 20)]
            ),height: 100,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("粉丝"),Text("6578")],),
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("关注"),Text("503")],),
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("文章"),Text("85")],),
                Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("收藏"),Text("135")],),
              ],),),),
            SliverToBoxAdapter(child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(0.0,2.0),spreadRadius: 2.0,blurRadius: 10.0)]
              ),
              height: 350,
              child: Column(children: [
                ListTile(onTap: (){
                  Navigator.pushNamed(context, '/task');
                },leading: Icon(Icons.event,color: Colors.deepOrange,),title: Text("任务大厅"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.pushNamed(context, '/interg');
                },leading: Icon(Icons.star,color: Colors.deepOrange,),title: Text("信用积分"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                Navigator.pushNamed(context, '/cremacpn');
                 },leading: Icon(Icons.assessment,color: Colors.deepOrange,),title: Text("我的动态"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.pushNamed(context, '/familcpn');
                },leading: Icon(Icons.audiotrack,color: Colors.deepOrange,),title: Text("团队管理"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.pushNamed(context, '/Photos');
                },leading: Icon(Icons.panorama,color: Colors.deepOrange,),title: Text("我的相册"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.pushNamed(context, '/feedbook');
                },leading: Icon(Icons.announcement,color: Colors.deepOrange,),title: Text("反馈意见"),trailing: Icon(Icons.chevron_right),),
              ],),
            ),),
            SliverToBoxAdapter(child: Container(margin: EdgeInsets.only(left: 10),child: Text("标签：",style: TextStyle(color: Colors.orange),)),),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Wrap(spacing: 10.0,children: [
                  for(var i=0;i<10;i++)
                    MaterialButton(color: Colors.blue[200],onPressed: (){},child: Text("家族族长"),)
                ],),
              ),
            )
          ],
        )
    );
  }
}
//ListView.builder(itemCount: 6,itemBuilder: (context,index){
//})