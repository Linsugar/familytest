import 'package:familytest/routes/routehander.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'routehander.dart';
class Routes{
  static String chatchild = '/chatchild';
  static String register = '/register';
  static String childfamily = '/childfamily';
  static String myseting = '/myseting';
  static String MainHome = '/MainHome';
  static String taskcpn = '/taskcpn';


  static void configureRoutes(FluroRouter router){
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
        print("页面有误");
        return;
      }
    );
    router.define(chatchild, handler: chatchildHander);
    router.define(register, handler: registerHander);
    router.define(childfamily, handler: childfamilyHander);
    router.define(myseting, handler:mysetinghander);
    router.define(MainHome, handler:MainHomeHandler);
    router.define(taskcpn, handler:taskcpnHandler);

  }
}