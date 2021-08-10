
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:familytest/main.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CommonUntil.dart';
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
  FocusNode _titleFocus = FocusNode();
  FocusNode _contextFocus = FocusNode();
  List imageDynamic = [];
  List upImage=[];
  var stateus=0;



//  发布动态
void upDynamic()async{
  var userInfo = context.read<GlobalState>().userInfo;
  var data  = FormData.fromMap({
    'user_id':userInfo['user_id'],
    'new_filename':'${DateTime.now().microsecondsSinceEpoch}'+'.jpg',
    'Up_Title':_titlecontroller.text,
    'Up_Context':_contextcontroller.text,
    'Up_addres':context.read<GlobalState>().city,
    'Up_name':userInfo['user_name'],
    'Up_avator':userInfo['avator_image'],
    'image':jsonEncode(upImage)
  });
  var result = await Request.setNetwork('DyImage/',data,token: context.read<GlobalState>().logintoken);
   print("返回的结果：$result");
     if(upImage.length==0){
       PopupUntil.showToast("请上传图片");
       return;
     }
    if(result["msg"] =="成功" && result["statues"] ==201){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
          MainHome()), (route) => false);
    }else{
      PopupUntil.showToast(result["msg"]);
      return;
    }
}

  @override
  Widget build(BuildContext context) {
  String ?token = context.watch<GlobalState>().qiNiuToken;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),title: Text("发布动态",style: TextStyle(color: Colors.black),),actions: [
          MaterialButton(onPressed: (){
            upDynamic();
      },child: Text("发表",style: TextStyle(color: Colors.black),),)],),
      body: GestureDetector(
        onTap: (){
          _titleFocus.unfocus();
          _contextFocus.unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
              Expanded(flex: 5,child: Container(
                color: Colors.white10,
                width: double.infinity,
                height: double.infinity,
                child: Form(
                  key: _globalKey,
                  autovalidateMode: AutovalidateMode.always,
                  child:Column(
                    children: [
                      Expanded(flex: 2,child: Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextFormField(
                          controller: _titlecontroller,
                          focusNode: _titleFocus,
                          decoration: InputDecoration(hintText: "添加标题",border: InputBorder.none),maxLines: 1,
                        ),
                      )),

                      Expanded(flex: 6,child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextFormField(
                            controller: _contextcontroller,
                            focusNode: _contextFocus,
                            maxLines: 15,decoration: InputDecoration(hintText: "请输入内容",border: InputBorder.none)),
                      )),
                      Text("*填写内容可以帮助你更快的舒缓心情",style: TextStyle(color: Colors.orange,),),
                      Expanded(flex: 4,child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for(var i=0;i<imageDynamic.length;i++)
                              Container(
                                width: MediaQuery.of(context).size.width/4.9,
                                height: MediaQuery.of(context).size.width/3,
                                margin: EdgeInsets.all(3),decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image:DecorationImage(image: FileImage(File(imageDynamic[i])),fit: BoxFit.cover)
                              ),),
                            imageDynamic.length==4?Text(""):MaterialButton(
                              onPressed: ()async{
                                var result = await Creamer.GetGrally();
                                print("得到的 结果：$result");
                                if(result == null){
                                  return;
                                }
                                var ImagePath = await qiNiuUpImage(result,token);
                                setState(() {
                                  if(result !=null){
                                    imageDynamic.add(result);
                                    upImage.add(ImagePath);
                                    stateus=1;
                                  }
                                });
                              },
                              child:Icon(Icons.add),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),),
              )),
              Expanded(flex: 3,child: Container(color: Colors.white,child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("选择帖子类别"),
                      ElevatedButton(onPressed: (){},child: Text("选择"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),),
                    ],),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){},child: Text("高血压"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),),
                    ],
                  )
                ],
              ),)),
            ],
          ),
        ),
      ),
    );
  }
}



