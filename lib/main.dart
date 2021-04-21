
import 'package:familytest/pages/login/login.dart';
import 'package:familytest/pages/mine/myui.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/routes/Rout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:familytest/roog/roogYun.dart';

void main() =>runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>GlobalState())
      ],
      child: MyApp(),));


class MyApp  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

 @override
 void initState(){
   Roogyun.rooginit();
   Roogyun.rooglistn();
   getDevice();
   // TODO: implement initState
   super.initState();
 }


 void getDevice()async{
   print("开始获取设备");
   var _device  =await _deviceInfo.androidInfo;
   if(Platform.isAndroid){
//   获取唯一Id
     context.read<GlobalState>().changdeviceid(_device.androidId);
     context.read<GlobalState>().changplatform(_device.device);
   }else if(Platform.isIOS){
     print("ios未操作");
   }
 }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutePage.onGenerateRoute,
      home: context.watch<GlobalState>().globalToken==false?MyHomePage():MainHome());
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  static int _index = 0;
  var _listwiget = [Home(),Family(),Chat(),myui()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_listwiget[_index],
      bottomNavigationBar:BottomNavigationBar(
        onTap: (value){print("value:$value");
        setState(() {
          _index = value;
        });
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "家族"),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "消息"),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "我的"),
        ],
      ),
    );
  }
}

