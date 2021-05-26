
import 'package:familytest/pages/login/login.dart';
import 'package:familytest/provider/grobleState.dart';
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(flex: 1,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/my.png')
                    )
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        left: 30,
                        bottom: 5,
                        child: Container(width: 100,height: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(context.watch<GlobalState>().avator!),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                        ))
                  ],
                ),
              )),
              Expanded(flex: 3,child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(flex: 1,child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${context.watch<GlobalState>().username}",style: TextStyle(
                                fontSize: 20,
                                fontWeight:FontWeight.w800 ),),
                            Text("身高-cm;体重-kg"),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/mysetting');
                          },
                          child: Container(width: 50,height: 50,decoration: BoxDecoration(
                              color: Colors.orange[700],
                              boxShadow: [BoxShadow(color: Colors.redAccent,blurRadius: 2.2,)],
                              borderRadius: BorderRadius.circular(50)),
                            child: Center(child: FaIcon(FontAwesomeIcons.edit,color: Colors.white,)),
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(flex:6,child: Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.all(5),
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.ticketAlt),title: Text("优惠卷"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.yenSign),title: Text("我的余额"),trailing: FaIcon(FontAwesomeIcons.angleRight),
                                onTap: (){
                                  Navigator.pushNamed(context, '/interg');
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.heartbeat),title: Text("所有服务"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.shoppingCart),title: Text("购买服务套餐"),trailing: FaIcon(FontAwesomeIcons.angleRight),
                                onTap: (){
                                  Navigator.pushNamed(context, '/task');
                                },),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(leading: FaIcon(FontAwesomeIcons.clipboard),title: Text("服务订单"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(leading: FaIcon(FontAwesomeIcons.clipboardList),title: Text("发起话题"),trailing: FaIcon(FontAwesomeIcons.angleRight),onTap: (){
                                Navigator.pushNamed(context, '/familcpn');
                              },),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.cogs),title: Text("设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),onTap: (){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage()), (route) => false);
                              },),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.shareAlt),title: Text("分享"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(leading: FaIcon(FontAwesomeIcons.globeAsia),title: Text("肾上线"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              )),
            ],
          ),
        )
    );
  }
}


//CustomScrollView(
//slivers: [
//SliverAppBar(
//actions: [
//IconButton(icon: Icon(Icons.settings),
//onPressed: (){
//Navigator.pushNamed(context, '/mysetting');
//})],
//flexibleSpace: FlexibleSpaceBar(
//background:Image.network(context.watch<GlobalState>().avator!,fit: BoxFit.cover,)
//),
//expandedHeight: 150,
//),
//SliverToBoxAdapter(
//child: Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(
//color: Colors.white,
//boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(0.0, 0.0),spreadRadius: 1.0,blurRadius: 20)]
//),height: 100,child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
//children: [
//Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("粉丝"),Text("6578")],),
//Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("关注"),Text("503")],),
//Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("文章"),Text("85")],),
//Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text("收藏"),Text("135")],),
//],),),),
//SliverToBoxAdapter(child: Container(
//margin: EdgeInsets.all(10),
//decoration: BoxDecoration(
//color: Colors.white,
//boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(0.0,2.0),spreadRadius: 2.0,blurRadius: 10.0)]
//),
//height: 350,
//child: Column(children: [
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/task');
//},leading: Icon(Icons.event,color: Colors.deepOrange,),title: Text("任务大厅"),trailing: Icon(Icons.chevron_right),),
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/interg');
//},leading: Icon(Icons.star,color: Colors.deepOrange,),title: Text("信用积分"),trailing: Icon(Icons.chevron_right),),
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/cremacpn');
//},leading: Icon(Icons.assessment,color: Colors.deepOrange,),title: Text("我的动态"),trailing: Icon(Icons.chevron_right),),
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/familcpn');
//},leading: Icon(Icons.audiotrack,color: Colors.deepOrange,),title: Text("团队管理"),trailing: Icon(Icons.chevron_right),),
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/Photos');
//},leading: Icon(Icons.panorama,color: Colors.deepOrange,),title: Text("我的相册"),trailing: Icon(Icons.chevron_right),),
//ListTile(onTap: (){
//Navigator.pushNamed(context, '/feedbook');
//},leading: Icon(Icons.announcement,color: Colors.deepOrange,),title: Text("反馈意见"),trailing: Icon(Icons.chevron_right),),
//],),
//),),
//SliverToBoxAdapter(child: Container(margin: EdgeInsets.only(left: 10),child: Text("标签：",style: TextStyle(color: Colors.orange),)),),
//SliverToBoxAdapter(
//child: Container(
//margin: EdgeInsets.only(left: 10),
//child: Wrap(spacing: 10.0,children: [
//for(var i=0;i<10;i++)
//MaterialButton(color: Colors.blue[200],onPressed: (){},child: Text("家族族长"),)
//],),
//),
//)
//],
//)