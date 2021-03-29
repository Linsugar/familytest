import 'dart:io';

import 'package:familytest/until/CreamUntil.dart';
import 'package:flutter/material.dart';
class cremacpn extends StatefulWidget {
  @override
  _cremacpnState createState() => _cremacpnState();
}

class _cremacpnState extends State<cremacpn> {
  var imagefile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("动态"),actions: [MaterialButton(onPressed: ()async{
        var file = await Creamer.GetCramer();
        setState(() {
          imagefile =file;
        });
      },child: Text("发布动态"),)],),
      body:Container(
        constraints: BoxConstraints.expand(),
        child: ListView.builder(itemCount: 20,itemBuilder: (context,index){
          return ExpansionTile(title: Align(alignment: Alignment.topLeft,child: Text("我是优秀的标题")),children: [
            ListTile(leading: Text("$index"),
                subtitle: Text("出擦啥快递萨拉丁卡拉的卡拉打卡打卡了的多久啊是快乐的手机卡的煎熬的"*4,
                  maxLines: 3,overflow: TextOverflow.ellipsis,),
                trailing: MaterialButton(onPressed: (){},child: Text("查看")))
          ],);
        }),
      )
    );
  }
}
