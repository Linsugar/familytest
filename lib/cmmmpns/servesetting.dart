import 'package:familytest/pages/login/login.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




//系统设置
class ServiceSetting extends StatefulWidget {
  @override
  _ServiceSettingState createState() => _ServiceSettingState();
}

class _ServiceSettingState extends State<ServiceSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(title: Text("设置",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: ListTile(onTap: (){
              PopupUntil.showToast("功能尚在开发中");
            },leading: Text("账号绑定设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
          ),
         Container(
           margin: EdgeInsets.only(bottom: 10,top: 10),
           color: Colors.white,
           child:ListTile(onTap: (){
           PopupUntil.showToast("功能尚在开发中");
         },leading: Text("消息提醒设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),),),
          Container(
            margin: EdgeInsets.only(bottom: 40,),
            color: Colors.white,
            child: ListTile(onTap: (){
              PopupUntil.showToast("功能尚在开发中");
            },leading: Text("注销账号",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,letterSpacing: 1.0),),trailing: FaIcon(FontAwesomeIcons.angleRight),),
          ),
          ElevatedButton(
            style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                shape: MaterialStateProperty.all(StadiumBorder(side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.orange
                )))
            ) ,
            child: Text("退出登录"),onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MyHomePage()), (route) => false);
          },),
        ],
      ),
    );
  }
}
