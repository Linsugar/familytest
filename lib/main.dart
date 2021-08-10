import 'dart:convert';
import 'package:familytest/pages/ToPic/ToPicHome.dart';
import 'package:familytest/pages/login/login.dart';
import 'package:familytest/pages/mine/childcpns/taskcpn.dart';
import 'package:familytest/pages/mine/myui.dart';
import 'package:familytest/provider/TaskState.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/routes/Rout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:familytest/roog/roogYun.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cmmmpns/updisease.dart';
import 'network/requests.dart';
import 'pages/home/model/model.dart';
import 'package:provider/provider.dart';

void main() =>runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>GlobalState()),
        ChangeNotifierProvider(create: (_)=>homeState(),child: Home(),),
        ChangeNotifierProvider(create: (_)=>taskState(),child: Task(),)
      ],
      child: MyApp(),));


class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  bool token = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var res;
  @override
  void initState(){
    _prefs.then((value) => {
      res = value.getString("token"),
      if(res!=null){
      Provider.of<GlobalState>(context,listen: false).changeUserInfo(jsonDecode(res)),
      Provider.of<GlobalState>(context,listen: false).changlogintoken(jsonDecode(res)["token"]),
      Provider.of<GlobalState>(context,listen: false).changeroogtoken(jsonDecode(res)["roogtoken"]),
      token = true
      }
    });
//   强制竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    Roogyun.rooginit();
    getDevice();
    // TODO: implement initState
    super.initState();
  }

//获取设备信息
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
        title: "家族",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutePage.onGenerateRoute,
        home: token== true?MainHome():MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  static int _index = 0;
  var _listWiget = [Home(),Topic(),Chat(),MyUi(),UpDiseaseCase()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed:(){
            setState(() {
              _index = 4;
            });
          } ,
        ),
        body:_listWiget[_index],
        backgroundColor: Colors.white,
        bottomNavigationBar:
        BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Tooltip(
                    message: '首页',
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            _index =0;
                          });
                        }
                        ,child:Column(
                      children: [
                        FaIcon(FontAwesomeIcons.themeisle,color: _index==0?Colors.deepOrange:Colors.black45,),
                        Text("首页")
                      ],
                    )),
                  ),
                  Tooltip(
                    message: '话题',
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            _index =1;
                          });
                        }
                        ,child: Column(
                      children: [
                        FaIcon(FontAwesomeIcons.users,color: _index==1?Colors.deepOrange:Colors.black45,),
                        Text("话题")
                      ],
                    )),
                  ),
                  SizedBox(),
                  Tooltip(
                    message: '消息',
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            _index =2;
                          });
                        }
                        ,child: Column(
                      children: [
                        FaIcon(FontAwesomeIcons.sms,color: _index==2?Colors.deepOrange:Colors.black45,),
                        Text("消息")
                      ],
                    )),
                  ),
                  Tooltip(
                    message: '我的',
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            _index =3;
                          });
                        }
                        ,child: Column(
                      children: [
                        FaIcon(FontAwesomeIcons.monero,color: _index==3?Colors.deepOrange:Colors.black45,),
                        Text("我的")
                      ],
                    )),
                  ),
                ],
              ),
            )
        )
    );
  }
}




