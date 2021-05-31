import 'package:familytest/cmmmpns/allservices.dart';
import 'package:familytest/cmmmpns/group.dart';
import 'package:familytest/cmmmpns/servesetting.dart';
import 'package:familytest/cmmmpns/seviceorder.dart';
import 'package:familytest/main.dart';
import 'package:familytest/pages/chat/Chatchild.dart';
import 'package:familytest/pages/chat/cpn/reviewcpn.dart';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/family/childcpns/ChildFamily.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/pages/home/childcps/archives.dart';
import 'package:familytest/pages/home/childcps/finddoctor.dart';
import 'package:familytest/pages/home/childcps/videocnps.dart';
import 'package:familytest/pages/home/childcps/webviewcps.dart';
import 'package:familytest/pages/login/login.dart';
import 'package:familytest/pages/login/register.dart';
import 'package:familytest/pages/mine/childcpns/mydynamic.dart';
import 'package:familytest/pages/mine/childcpns/dynamicUp.dart';
import 'package:familytest/pages/mine/childcpns/dynamicpn.dart';
import 'package:familytest/pages/mine/childcpns/familycpns.dart';
import 'package:familytest/pages/mine/childcpns/feedback.dart';
import 'package:familytest/pages/mine/childcpns/intergcpn.dart';
import 'package:familytest/pages/mine/childcpns/mysetting.dart';
import 'package:familytest/pages/mine/childcpns/taskcpn.dart';
import 'package:flutter/material.dart';

class RoutePage{
 static final routeName = {
    '/task':(context,{argument})=>Task(),
    '/Photos':(context,{argument})=>Photos(),
    '/mysetting':(context,{argument})=>MySetting(),
    '/childfamily':(context,{argument})=>childfamily(argument),
    '/mydynamic':(context,{argument})=>MyDynamic(),
    '/chatChild':(context,{argument})=>ChatChild(argument),
    '/Home':(context,{argument})=>Home(),
    '/feedbook':(context,{argument})=>FeedBook(),
    '/interg':(context,{argument})=>interg(),
    '/familcpn':(context,{argument})=>FamilyCpn(),
    '/Regitser':(context,{argument})=>Regitser(),
    '/updynamic':(context,{argument})=>UpDynamic(),
    '/videoWidget':(context,{argument})=>videoWidget(argument),
    '/webviewcpns':(context,{argument})=>webviewcpns(argument),
    '/MyHomePage':(context,{argument})=>MyHomePage(),
    '/reviewCpn':(context,{argument})=>ReviewCpn(argument),
    '/createGroup':(context,{argument})=>CreateGroup(),
    '/MainHome':(context,{argument})=>MainHome(),
    '/doctor':(context,{argument})=>FindDoctor(),
    '/archives':(context,{argument})=>Archives(),
    '/services':(context,{argument})=>AllServices(),
    '/servesetting':(context,{argument})=>ServiceSetting(),
    '/order':(context,{argument})=>ServiceOrder(),
  };

// ignore: missing_return, top_level_function_literal_block
 static var onGenerateRoute = (RouteSettings settings) {
    print("获取到的setting：${settings.name}");
    final String ?name = settings.name;
    final Function ?pageContentBuilder = routeName[name];
    if (pageContentBuilder != null) {
      //能寻找到对应的路由
      if (settings.arguments != null) {
        //页面跳转前有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context, argument: settings.arguments));
        return route;
      } else {
        //页面跳转前没有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  };

}



