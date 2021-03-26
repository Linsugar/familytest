import 'package:familytest/main.dart';
import 'package:familytest/pages/family/childcpns/ChildFamily.dart';
import 'package:familytest/pages/chat/Chatchild.dart';
import 'package:familytest/pages/login/register.dart';
import 'package:familytest/pages/mine/childcpns/mysetting.dart';
import 'package:familytest/pages/mine/childcpns/taskcpn.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

//聊天页面
Handler chatchildHander = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return chatChild();
  }
);
//注册详情页面
Handler registerHander = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return Regitser();
  }
);

//家族详情页面
Handler childfamilyHander = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return childfamily();
  }
);

//我的资料页面
Handler mysetinghander = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return mysetting();
  }
);

Handler MainHomeHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return MainHome();
  }
);

Handler taskcpnHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return task();
  }
);