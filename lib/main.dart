import 'package:familytest/pages/mine/childcpns/mysetting.dart';
import 'package:familytest/pages/mine/myui.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/routes/application.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/family/childcpns/ChildFamily.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/routes/route.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
 static int _index = 0;

  @override
  Widget build(BuildContext context) {
    final  FluroRouter router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      home: Scaffold(
      body:IndexedStack(key: UniqueKey(),index: _index,children: [
        Home(),
        Chat(),
        Family(),
//        childfamily(),
        myui()
//        mysetting()
        // Login()
      ],),
      bottomNavigationBar: BottomNavigationBar(
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
    ),);
  }
}