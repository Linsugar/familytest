import 'dart:convert';

import 'file:///D:/tang/Project/familytest/lib/pages/home/model/model.dart';
import 'package:familytest/pages/login/login.dart';
import 'package:familytest/pages/mine/childcpns/taskcpn.dart';
import 'package:familytest/pages/mine/myui.dart';
import 'package:familytest/provider/TaskState.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/pages/chat/Chat.dart';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/routes/Rout.dart';
import 'package:familytest/until/shared.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:familytest/until/wx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:familytest/roog/roogYun.dart';

import 'network/requests.dart';

void main() =>runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>GlobalState()),
        ChangeNotifierProvider(create: (_)=>homeState(),child: Home(),),
        ChangeNotifierProvider(create: (_)=>taskState(),child: task(),)
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
  bool token=false;
 @override
 void initState(){
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
//   Wx.initwx();
   getDevice();
   getPreferecse();
   _getuserinfo();
   _getVideoContext();
   // TODO: implement initState
   super.initState();
 }

// 初始化首页图片-预加载图片
  _Getimage()async{
    var im = await rootBundle.loadString('data/home.json');
    print("数据返回：${im}");
    var imagedeoce  = json.decode(im);
    print("数据返回：${imagedeoce.length}");
    imagedeoce.forEach((value){
      Provider.of<homeState>(context,listen: false).changelist(value);
    });
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
//获取缓存内容
 getPreferecse()async{
 var _token =  await Shared.getdata('token');
 print("获取token值${_token}");
  if(_token !=null){
    var _avator =  await Shared.getdata('avator_image');
    Provider.of<GlobalState>(context,listen: false).changeavator(_avator);
    var _logintoken =  await Shared.getdata('token');
    Provider.of<GlobalState>(context,listen: false).changlogintoken(_logintoken);
    var _user_id=  await Shared.getdata('user_id');
    Provider.of<GlobalState>(context,listen: false).changuserid(_user_id);
    var _roogtoken=  await Shared.getdata('roogtoken');
    Provider.of<GlobalState>(context,listen: false).changeroogtoken(_roogtoken);
    var _user_name=  await Shared.getdata('user_name');
    Provider.of<GlobalState>(context,listen: false).changeusername(_user_name);
    setState(() {
      token =true;
    });
  }
 }

_getuserinfo()async{
  Provider.of<GlobalState>(context,listen: false).overuser!.clear();
  var result = await Request.getNetwork('userinfo/',params: {
    'user_id':context.read<GlobalState>().userid
  });
  for(var i=0;i<result.length;i++){
    Provider.of<GlobalState>(context,listen: false).changealluser(userinfomodel(result[i]));
  }
}

//获取视频热点
_getVideoContext()async{
  List<VideoInfo> videoList= [];
  List _res = await Request.getNetwork('video/');
  _res.forEach((element) {
    videoList.add(VideoInfo(element));
  });
  Provider.of<homeState>(context,listen: false).changeVideo(videoList);
  print("得到的结果：${videoList}");
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "家族",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutePage.onGenerateRoute,
      home: token==true?MainHome():MyHomePage());
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed:(){
          PopupUntil.showToast("当前功能正在开发中");
        } ,
      ),
      body:_listwiget[_index],
      backgroundColor: Colors.white,
      bottomNavigationBar:
      BottomNavigationBar(
        selectedItemColor: Colors.orange,
        onTap: (value){print("value:$value");
        setState(() {
          _index = value;
        });
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.themeisle),label: "首页"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.users),label: "话题"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.sms),label: "社区"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.monero),label: "我的"),
        ],
      ),
    );
  }
}

