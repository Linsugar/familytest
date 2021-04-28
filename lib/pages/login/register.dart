
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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

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
  Artboard ?_riveArtboard;
  RiveAnimationController ?_controller;
  String _file = 'assets/67-93-flux-capacitor.riv';

  @override
  void initState() {
    _createRive(_controller);
    // TODO: implement initState
    super.initState();
  }
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
              Container(
                  child: _riveArtboard == null
                      ? const SizedBox():
                  Rive(artboard: _riveArtboard!,fit: BoxFit.cover,)
              ),
              context.read<GlobalState>().loadstatue?Center(child: CircularProgressIndicator()):Container(),
              Container(
                child: Flex(direction: Axis.vertical,children: [
                  Expanded(flex: 3,child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          GestureDetector(
                            onTap: ()async{
                                var path =await Creamer.GetGrally();
                                setState(() {
                                  avator = path;
                                }
                                );
                            },
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                                width: 70,
                                height: 70,
                                child: avator ==null?Center(
                                    child: FaIcon(FontAwesomeIcons.camera)):Image(image: FileImage(File(avator!)),fit: BoxFit.cover,),
                              ),
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
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          maxLength: 13,maxLines: 1,decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            icon: FaIcon(FontAwesomeIcons.mobileAlt,color: Colors.white,),
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
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          maxLength: 5,maxLines: 1,decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            icon: FaIcon(FontAwesomeIcons.userTie,color: Colors.white,),
                            hintText: "请输入用户名",
                            labelText: "用户名"
                        ),),
                        SizedBox(height: 10,),
                        TextFormField(
                          onFieldSubmitted: (value)async{
                           await regis(context);
                          },
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
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
                            icon:FaIcon(FontAwesomeIcons.key,color: Colors.white,),
                            hintStyle: TextStyle(color: Colors.white),
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
                            ElevatedButton.icon(onPressed: ()async{
                              Provider.of<GlobalState>(context,listen: false).changeloads(true);
                              await regis(context);
                            }, icon: FaIcon(FontAwesomeIcons.registered), label: Text("注册")),
                            SizedBox(width: 10,),
                            ElevatedButton.icon(onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            }, icon: FaIcon(FontAwesomeIcons.signInAlt), label: Text("登录")),
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

  Future regis(BuildContext context) async {
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
          Provider.of<GlobalState>(context,listen: false).changeloads(false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MainHome();
          }));
        }
      }else{
        PopupUntil.showToast("能不能上传照片？");
      }
    }
  }

  void _createRive(contlr)async {
    rootBundle.load(_file).then(
//      1.加载riv文件，
          (data) async {
        print("data:$data");
//            创建一个存储rive二进制的文件
        final file =RiveFile.import(data);
        print("$file文件");
        final artboard = file.mainArtboard;
//          添加一个控制器，随时进行控制动画
        artboard.addController(contlr = SimpleAnimation('Animation'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }
}



