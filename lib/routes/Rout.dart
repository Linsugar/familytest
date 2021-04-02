import 'package:familytest/pages/chat/Chatchild.dart';
import 'package:familytest/pages/family/childcpns/ChildFamily.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/pages/mine/childcpns/cremracpn.dart';
import 'package:familytest/pages/mine/childcpns/dynamicpn.dart';
import 'package:familytest/pages/mine/childcpns/familycpns.dart';
import 'package:familytest/pages/mine/childcpns/feedBook.dart';
import 'package:familytest/pages/mine/childcpns/intergcpn.dart';
import 'package:familytest/pages/mine/childcpns/mysetting.dart';
import 'package:familytest/pages/mine/childcpns/taskcpn.dart';
import 'package:flutter/material.dart';

class RoutePage{
 static final routeName = {
    '/task':(context,{argument})=>task(),
    '/Photos':(context,{argument})=>Photos(),
    '/mysetting':(context,{argument})=>mysetting(),
    '/childfamily':(context,{argument})=>childfamily(),
    '/cremacpn':(context,{argument})=>cremacpn(),
    '/chatChild':(context,{argument})=>chatChild(),
    '/Home':(context,{argument})=>Home(),
    '/feedbook':(context,{argument})=>feedbook(),
    '/interg':(context,{argument})=>interg(),
    '/familcpn':(context,{argument})=>familcpn(),
  };

// ignore: missing_return, top_level_function_literal_block
 static var onGenerateRoute = (RouteSettings settings) {
    print("获取到的setting：${settings.name}");
    final String name = settings.name;
    final Function pageContentBuilder = routeName[name];
    if (pageContentBuilder != null) {
      //能寻找到对应的路由
      if (settings.arguments != null) {
        //页面跳转前有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
        return route;
      } else {
        //页面跳转前没有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  };

}



