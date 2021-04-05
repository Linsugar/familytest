import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mysetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mysettingstate();
  }
}

class mysettingstate extends State<mysetting>{
  String _imagrurl = 'http://qr0n4nltx.hn-bkt.clouddn.com/imagesp1.jpg';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("个人信息"),actions: [MaterialButton(onPressed: (){},child: Text("保存",style: TextStyle(color: Colors.white),),)],),
      body: Container(child: Flex(direction: Axis.vertical,children: [
        Flexible(flex: 4,child: Container(
          padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top: 5,bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.deepOrange,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("头像"),],),
                Row(children: [
                  CircleAvatar(backgroundImage: NetworkImage(_imagrurl),),Icon(Icons.chevron_right)
                ],)],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("昵称"),],), Row(children: [Text("九曜魔王"),Icon(Icons.chevron_right)],)],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("性别"),],), Row(children: [Text("女"),Icon(Icons.chevron_right)],)],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("ID"),],), Row(children: [Text("155687421zs"),Icon(Icons.chevron_right)],)],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("个性签名"),],), Row(children: [Text("千年轮回"),Icon(Icons.chevron_right)],)],)
            ],

          )
          ),
        ),
        Flexible(flex: 3,child:  Container(
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 5,bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.deepOrange,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
            ),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("生日"),],), Row(children: [Text("2月06日"),Icon(Icons.chevron_right)],)],)
            ,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("星座"),],), Row(children: [Text("水瓶座"),Icon(Icons.chevron_right)],)],)
            ,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("地区"),],), Row(children: [Text("四川-成都"),Icon(Icons.chevron_right)],)],)
          ],

        ))),
        Flexible(flex: 3,child:  Container(
            margin: EdgeInsets.only(top: 5,),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.deepOrange,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
            ),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Icon(Icons.account_circle),Text("绑定QQ"),],), Row(children: [Text("888888"),SizedBox(width: 5,),
                MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))) ,color: Colors.blue,onPressed: (){},child: Text("绑定"),)],)],)
            ,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Icon(Icons.account_circle),Text("绑定微信"),],), Row(children: [Text("888888"),SizedBox(width: 5,),
              MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))) ,color: Colors.blue,onPressed: (){},child: Text("绑定"),)],)],)
            ,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Icon(Icons.account_circle),Text("绑定微博"),],), Row(children: [Text("888888"),
              SizedBox(width: 5,),
              MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))) ,color: Colors.blue,onPressed: (){},child: Text("绑定"),)],)],)
          ],

        ))),
      ],),),
    );
  }
}