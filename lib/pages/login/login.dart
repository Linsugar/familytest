import 'dart:math';

import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/shared.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:provider/provider.dart';
import 'package:familytest/pages/login/register.dart';
import '../../main.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key ?key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  GlobalKey<FormState> ?_fromglobalKey = GlobalKey<FormState>();
  TextEditingController ?_Usercontroller  =TextEditingController();
  TextEditingController ?_Pwdcontroller  =TextEditingController();
  Artboard ?_riveArtboard;
  RiveAnimationController ?_controller;
  String _file = 'assets/flag.riv';
  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
//              child: Image(image:  AssetImage('images/login.jpg'),fit: BoxFit.cover,),
            ),
            Positioned(top: 30,right: 10,child: MaterialButton(child: Text("注册",style: TextStyle(color: Colors.white),),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Regitser()));
            },)),
            Positioned(
              top: MediaQuery.of(context).size.height/3,
              left: 0,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child:Container(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _fromglobalKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: _Usercontroller,
                            keyboardType: TextInputType.phone,
                            maxLength: 13,
                            validator: (user){
                              if(user!.isEmpty || user.length<5){
                                return "用户名有误";
                              }return null;
                            },
                            decoration: InputDecoration(
                                hintText: "请输入手机号码",
                                icon: Icon(Icons.account_circle)),),
                          TextFormField(
                            validator: (pwd){
                              if(pwd!.isEmpty || pwd.length<5){
                                return "密码有误";
                              }return null;
                            },
                            obscureText: true,
                            keyboardType:TextInputType.number ,
                            controller: _Pwdcontroller,
                            decoration: InputDecoration(
                                hintText: "请输入密码",
                                icon: Icon(Icons.add_call)),
                            maxLength: 15,
                          ),
                          Row
                            (mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                            ElevatedButton.icon(onPressed: ()async{
                              if( _fromglobalKey!.currentState!.validate()){
                                var userdata = FormData.fromMap({
                                  'user_mobile':_Usercontroller?.text,
                                  'password':_Pwdcontroller?.text
                                });
                                var loginResult =  await Request.setNetwork('user/',userdata);
                                var token = loginResult['token'];
                                if(token !=null){
                                  PopupUntil.showToast(loginResult['msg']);
                                  context.read<GlobalState>().changToken(false);
                                  context.read<GlobalState>().changlogintoken(loginResult['token']);
                                  context.read<GlobalState>().changuserid(loginResult['user_id']);
                                  context.read<GlobalState>().changeavator(loginResult['avator_image']);
                                  context.read<GlobalState>().changeroogtoken(loginResult['roogtoken']);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                      MainHome()));
                                }
                                if(loginResult['msg']=='密码或手机号有误'){
                                  PopupUntil.showToast(loginResult['msg']);
                                }
                                if(loginResult['msg']=='不存在'){
                                PopupUntil.showToast(loginResult['msg']);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                    Regitser()));
                              }
                              }
                              }, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("登录")),
                            ElevatedButton.icon(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Regitser()));
                              }, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("注册"))
                          ],),
                        ],
                      ),
                    ),
                  ),

                ),
              ),),
          ],
        ),
      ),
    );
  }
  void _createRive()async{
    rootBundle.load(_file).then(
//      1.加载riv文件，
          (data) async {
        print("data:$data");
//            创建一个存储rive二进制的文件
        final file =RiveFile.import(data);
        print("$file文件");
        final artboard = file.mainArtboard;
//          添加一个控制器，随时进行控制动画
        artboard.addController(_controller = SimpleAnimation('flag'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }
}


