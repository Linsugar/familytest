import 'package:familytest/pages/login/login.dart';
import 'package:familytest/pages/mine/myui.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/routes/Rout.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/home/Home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';

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
  var _devices_info;
 @override
 void initState() {
   _devices_info = DeviceInfoPlugin();
   // TODO: implement initState

   super.initState();
 }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutePage.onGenerateRoute,
      home: context.watch<GlobalState>().globalToken==false?Login():MainHome());
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  static int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(key: UniqueKey(),index: _index,children: [
        Home(),
        Chat(),
        Family(),
        myui(),
      ],),
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
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "消息"),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "家族"),
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: "我的"),
        ],
      ),
    );
  }
}

