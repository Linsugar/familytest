
import 'package:familytest/pages/mine/childcpns/cremracpn.dart';
import 'package:familytest/pages/mine/childcpns/dynamicpn.dart';
import 'package:familytest/routes/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myui extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myuistate();
  }
}

class myuistate extends State<myui>{
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
//            leading: Text("我的",style: TextStyle(fontSize: 20,color: Colors.black),),
            actions: [IconButton(icon: Icon(Icons.fullscreen),
            onPressed: (){}),
              IconButton(icon: Icon(Icons.settings),
            onPressed: (){
                Application.router.navigateTo(context, '/myseting');
            })],
            flexibleSpace: FlexibleSpaceBar(
              background:Image.network(_imagrurl,fit: BoxFit.cover,)
            ),
            expandedHeight: 150,
          ),
          SliverToBoxAdapter(child: Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(
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
                  Application.router.navigateTo(context, '/taskcpn');
                },leading: Icon(Icons.event,color: Colors.deepOrange,),title: Text("任务大厅"),trailing: Icon(Icons.chevron_right),),
                ListTile(leading: Icon(Icons.star,color: Colors.deepOrange,),title: Text("我的积分"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return cremacpn();
                  }));
                },leading: Icon(Icons.assessment,color: Colors.deepOrange,),title: Text("我的动态"),trailing: Icon(Icons.chevron_right),),
                ListTile(leading: Icon(Icons.audiotrack,color: Colors.deepOrange,),title: Text("家族职位"),trailing: Icon(Icons.chevron_right),),
                ListTile(onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Photos();
                  }));
                },leading: Icon(Icons.panorama,color: Colors.deepOrange,),title: Text("我的相册"),trailing: Icon(Icons.chevron_right),),
                ListTile(leading: Icon(Icons.announcement,color: Colors.deepOrange,),title: Text("反馈意见"),trailing: Icon(Icons.chevron_right),),
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