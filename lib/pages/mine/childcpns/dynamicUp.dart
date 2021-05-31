import 'dart:io';
import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpDynamic extends StatefulWidget {
  @override
  _UpDynamicState createState() => _UpDynamicState();
}

class _UpDynamicState extends State<UpDynamic> {
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
        print("返回的user_id：${context.read<GlobalState>().userid}");
        var data  = FormData.fromMap({
          'image':[],
          'user_id':context.read<GlobalState>().userid,
          'new_filename':'${DateTime.now().microsecondsSinceEpoch}'+'.jpg',
          'up_title':_titlecontroller.text,
          'up_context':_contextcontroller.text,
          'up_addres':context.read<GlobalState>().city,
          'up_name':context.read<GlobalState>().username,
          'up_avator':context.read<GlobalState>().avator,
        });
        for(var i=0;i<imageDynamic.length;i++){
          data.files.add(
            MapEntry('image',
              await MultipartFile.fromFile(imageDynamic[i])
            )
          );
        }
        var result = await Request.setNetwork('DyImage/',data,token: context.read<GlobalState>().logintoken);
        print("返回的结果：$result");
        if(result['user_id'] == context.read<GlobalState>().userid){
          PopupUntil.showToast('发布成功，请稍后');
          Navigator.pop(context);
        }else{
          PopupUntil.showToast('上传失败,请稍后重试');
        }

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
                      Container(
                        width: MediaQuery.of(context).size.width/5,
                        height: MediaQuery.of(context).size.width/3,
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
                )),
              ],
            ),)),
            Expanded(flex: 5,child: Container(color: Colors.white,)),
          ],
        ),
      ),
    );
  }
}



