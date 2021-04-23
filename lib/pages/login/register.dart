
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:familytest/until/shared.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:familytest/pages/login/login.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
class Regitser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Regitser>{
  bool checkbool = false;
  bool sexbool = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _phoneController  =TextEditingController();
  TextEditingController _userController  =TextEditingController();
  TextEditingController _pwdController  =TextEditingController();
  String ?avator;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/login.jpg'),fit: BoxFit.cover)),
                  child: Flex(direction: Axis.vertical,children: [
                    Expanded(flex: 3,child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                          children:[
                            Expanded(flex:2,child: Text("")),
                            ClipOval(
                              child: Container(
                                color: Colors.white,
                                width: 70,
                                height: 70,
                                child: avator ==null?Center(child: GestureDetector(
                                    onTap: ()async{
                                      var path =await Creamer.GetGrally();
                                      setState(() {
                                        avator = path;
                                      });
                                    },
                                    child: FaIcon(FontAwesomeIcons.camera))):Image(image: FileImage(File(avator!)),fit: BoxFit.cover,),
                              ),
                            ),
                            SizedBox(height: 10,),
                          ]
                      ),
                    ),),
                    Expanded(flex:7,child: Container(padding: EdgeInsets.all(10),child: Form(
                      autovalidateMode:AutovalidateMode.always ,
                      key: _globalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty ||  value.length !=11){
                                print("当前类型：${value.runtimeType}");
                                return "手机号码输入有误";
                              }else{
                                return null;
                              }
                            },
                            controller: _phoneController,
                            keyboardType:TextInputType.phone ,
                            maxLength: 13,maxLines: 1,decoration: InputDecoration(
                              icon: Icon(Icons.account_circle,color: Colors.blue,),
                              hintText: "请输入手机号码",
                              labelText: "手机号"
                          ),),
                          SizedBox(height: 10,),
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty || value.length >5){
                                return "用户名输入有误";
                              }else{
                                return null;
                              }
                            },
                            keyboardType:TextInputType.name,
                            controller: _userController,
                            maxLength: 5,maxLines: 1,decoration: InputDecoration(
                              icon: Icon(Icons.account_circle,color: Colors.blue,),
                              hintText: "请输入用户名",
                              labelText: "用户名"
                          ),),
                          SizedBox(height: 10,),
                          TextFormField(
                            obscureText: true,
                            keyboardType:TextInputType.phone,
                            validator: (value){
                              if(value!.isEmpty || value.length <5){
                                return "请正确输入密码";
                              }else{
                                return null;
                              }
                            },
                            controller: _pwdController,
                            maxLength: 10,maxLines: 1,decoration: InputDecoration(
                              icon: Icon(Icons.account_circle,color: Colors.blue,),
                              hintText: "请输入密码",
                              labelText: "密码"
                          ),),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Text("男"),
                            Switch(value: sexbool, onChanged: (value){
                              setState(() {
                                sexbool = value;
                              });
                            }),
                            Text("女")
                          ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            MaterialButton(color: Colors.red,child: Text("注册"),onPressed: ()async{
                              if(_globalKey.currentState!.validate()){
                                if(avator !=null){
                                  var formdata = FormData.fromMap({
                                    'user_mobile':_phoneController.text,
                                    'password':_pwdController.text,
                                    'username':_userController.text,
                                    'city':context.read<GlobalState>().city,
                                    'deviceid':context.read<GlobalState>().deviceid,
                                    'platform':context.read<GlobalState>().platform,
                                    'avator_image': await MultipartFile.fromFile(avator!)
                                  });
                                  var  Resultdata = await Request.setNetwork('user/', formdata);
                                  String ?token = Resultdata['token'];
                                  if(token!.isNotEmpty){
                                    PopupUntil.showToast(Resultdata['msg']);
                                    context.read<GlobalState>().changuserid(Resultdata['user_id']);
                                    context.read<GlobalState>().changeavator(Resultdata['avator_image']);
                                    context.read<GlobalState>().changeroogtoken(Resultdata['roogtoken']);
                                    context.read<GlobalState>().changeusername(Resultdata['username']);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                      return MainHome();
                                    }));
                                  }
                                }else{
                                  PopupUntil.showToast("能不能上传照片？");
                                }
                              }
                            },),
                            SizedBox(width: 10,),
                            MaterialButton(color: Colors.blue,child: Text("登录"),onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            },),
                          ],)
                        ],
                      ),
                    ),)),
                  ],),),
              ],
            ),
          ),
      ),
    );
  }
}



