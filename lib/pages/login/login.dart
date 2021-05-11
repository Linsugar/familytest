import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/until/shared.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String _file = 'assets/139-250-walkcycle-try-02.riv';
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';


  @override
  void initState(){
//    _createRive(_controller);
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Flex(direction: Axis.vertical,children: [
                Expanded(flex: 5,child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/first.jpg')
                          ,fit: BoxFit.cover
                      )
                  ),
                ),),
                Expanded(flex: 5,child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)),
                  ),
                  child:Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          top: -10,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            decoration: BoxDecoration(
                            color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.white30,spreadRadius: 0.2,offset: Offset(0.0,-1.0))],
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)),
                            ),
                            height: MediaQuery.of(context).size.height/2+10,
                            child:  Form(
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
                                        icon: FaIcon(FontAwesomeIcons.mobileAlt,color: Colors.blue,)),),
                                  TextFormField(
                                    onFieldSubmitted: (value){
                                      relogin(context);
                                    },
                                    validator: (pwd){
                                      if(pwd!.isEmpty || pwd.length<5){
                                        return "密码有误";
                                      }return null;
                                    },
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    keyboardType:TextInputType.number ,
                                    controller: _Pwdcontroller,
                                    decoration: InputDecoration(
                                        hintText: "请输入密码",
                                        icon:FaIcon(FontAwesomeIcons.key,color: Colors.blue,),),
                                    maxLength: 15,

                                  ),
                                  Flex(direction: Axis.horizontal,children: [
                                    Expanded(flex: 6,child: Container(height:50,
                                      child: ElevatedButton.icon(onPressed: (){
                                        Provider.of<GlobalState>(context,listen: false).changeloads(true);
                                        relogin(context);
                                      }, icon: FaIcon(FontAwesomeIcons.signInAlt), label: Text("登录")),
                                    )),
                                    SizedBox(width: 10,),
                                    Expanded(flex: 4, child: Container(
                                        height: 50,
                                      child:ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                          shape:MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(20))) )
                                      ,onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Regitser()));
                                      }, icon: FaIcon(FontAwesomeIcons.signInAlt), label: Text("注册"))),
                                    ),
                                  ],),
                                  MaterialButton(onPressed: (){
//                              Wx.wxlogin();
                                    PopupUntil.showToast("功能暂未开放");
                                  },child: Text("微信登录"),)
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                )),

              ],)
            ],
          ),
        ),
      )
    );
  }
  Future relogin(BuildContext context) async {
    if( _fromglobalKey!.currentState!.validate()){
      var userdata = FormData.fromMap({
        'user_mobile':_Usercontroller?.text,
        'password':_Pwdcontroller?.text
      });
      var loginResult =  await Request.setNetwork('user/',userdata);
      Provider.of<GlobalState>(context,listen: false).changeloads(false);
      if(loginResult['token'] !=null){
        PopupUntil.showToast(loginResult['msg']);
        context.read<GlobalState>().changlogintoken(loginResult['token']);
        context.read<GlobalState>().changuserid(loginResult['user_id']);
        context.read<GlobalState>().changeavator(loginResult['avator_image']);
        context.read<GlobalState>().changeroogtoken(loginResult['roogtoken']);
        context.read<GlobalState>().changeusername(loginResult['user_name']);
        _setprrferceAll(loginResult);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
            MainHome()));
      }
      if(loginResult['msg']=='密码或手机号有误'){
        Provider.of<GlobalState>(context,listen: false).changeloads(false);
        PopupUntil.showToast(loginResult['msg']);
      }
      if(loginResult['msg']=='不存在'){
        Provider.of<GlobalState>(context,listen: false).changeloads(false);
      PopupUntil.showToast(loginResult['msg']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          Regitser()));
    }
    }
  }

//  登录时进行缓存设置
  _setprrferceAll(loginResult)async{
    await Shared.setdata('token', loginResult['token']);
    await Shared.setdata('user_id', loginResult['user_id']);
    await Shared.setdata('avator_image', loginResult['avator_image']);
    await Shared.setdata('roogtoken', loginResult['roogtoken']);
    await Shared.setdata('user_name', loginResult['user_name']);
  }


//  void _createRive(contlr)async{
//    rootBundle.load(_file).then(
////      1.加载riv文件，
//          (data) async {
//        print("data:$data");
////            创建一个存储rive二进制的文件
//        final file =RiveFile.import(data);
//        print("$file文件");
//        final artboard = file.mainArtboard;
////          添加一个控制器，随时进行控制动画
//        artboard.addController(contlr = SimpleAnimation('Walkcycle'));
//        setState(() => _riveArtboard = artboard);
//      },
//    );
//  }

}

