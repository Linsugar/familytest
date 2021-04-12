import 'dart:io';
import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class updynamic extends StatefulWidget {
  @override
  _updynamicState createState() => _updynamicState();
}

class _updynamicState extends State<updynamic> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _titlecontroller =TextEditingController();
  TextEditingController _contextcontroller =TextEditingController();
  List imageDynamic = [];

  var stateus=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("发布动态"),actions: [MaterialButton(onPressed: ()async{
        print("返回的图片地址：${imageDynamic[0]}");
        print("返回的user_id：${context.read<GlobalState>().userid}");
        print("返回的图片地址：${imageDynamic[0]}");
        var data  = FormData.fromMap({
          'image':await MultipartFile.fromFile(imageDynamic[0]),
          'user_id':context.read<GlobalState>().userid,
          'new_filename':'${DateTime.now().microsecondsSinceEpoch}'+'.jpg',
          'up_title':_titlecontroller.text,
          'up_context':_contextcontroller.text,
          'up_addres':context.read<GlobalState>().city,
        });


        var result = await Request.setNetwork('DyImage/',data);
        print("返回的结果：$result");

      },child: Text("发表",style: TextStyle(color: Colors.white),),)],),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Expanded(flex: 5,child: Form(
              key: _globalKey,
              autovalidateMode: AutovalidateMode.always,
              child:Column(
              children: [
                Expanded(flex: 2,child: TextFormField(
                  controller: _titlecontroller,
                  decoration: InputDecoration(hintText: "请输入标题"),maxLength: 15,)),
                Expanded(flex: 6,child: TextFormField(
                    controller: _contextcontroller,
                    maxLines: 15,decoration: InputDecoration(hintText: "请输入内容"))),
                Expanded(flex: 4,child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(var i=0;i<imageDynamic.length;i++)
                      Expanded(flex:1,child:Container(margin: EdgeInsets.all(3),decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image:DecorationImage(image: FileImage(File(imageDynamic[i])),fit: BoxFit.cover)
                      ),)),
                    imageDynamic.length==4?Text(""):MaterialButton(
                      onPressed: ()async{
                        var reslut = await Creamer.GetGrally();
                        print("得到的结果：${reslut}");
                        setState(() {
                          imageDynamic.add(reslut);
                          stateus=1;
                          print("得到的图片内容：${imageDynamic}");
                        });
                        print("得到的图片内容：${imageDynamic.isEmpty}");
                      },
                      child:Icon(Icons.add),
                    )
                  ],
                )),
              ],
            ),)),
            Expanded(flex: 5,child: Container(color: Colors.blueGrey,)),
          ],
        ),
      ),
    );
  }
}



