import 'dart:io';

import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class createGroup extends StatefulWidget {
  @override
  _createGroupState createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  List imageDynamic = [];
  var stateus=0;
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("创建团队"),),
      body: Container(
        width: _size.width,
        height: _size.height,
        child:Form(
            child: Column(
          children: [
            TextFormField(decoration: InputDecoration(hintText: "请输入团队名称"),),
            Row(children: [
              Text("请上传团队封面",textAlign: TextAlign.start,)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(var i=0;i<imageDynamic.length;i++)
                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    height: MediaQuery.of(context).size.width/4,
                    margin: EdgeInsets.all(3),decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image:DecorationImage(image: FileImage(File(imageDynamic[i])),fit: BoxFit.cover)
                  ),),
                imageDynamic.length==4?Text(""):MaterialButton(
                  onPressed: ()async{
                    var reslut = await Creamer.GetGrally();
                    print("得到的结果：${reslut}");
                    setState(() {
                      if(reslut !=null){
                        imageDynamic.add(reslut);
                        stateus=1;
                        print("得到的图片内容：${imageDynamic}");
                        print("得到的图片长度：${imageDynamic.length}");
                      }
                    });
                  },
                  child:Icon(Icons.add),
                )
              ],
            ),
            TextFormField(decoration: InputDecoration(hintText: "请输入团队宣言"),),
            Row(children: [
              Text("团队类型",textAlign: TextAlign.start,)
            ],),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Text("11"),
                  Text("11"),
                  Text("11"),
                  Text("11"),
                ],
              ),
            ),
            Expanded(flex: 7,child: Container(color: Colors.blue,)),

          ],
        ))
      ),
    );
  }
}
