import 'dart:ui';
import 'package:familytest/network/requests.dart';
import 'package:flutter/material.dart';
import 'package:familytest/pages/login/login.dart';
class Regitser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Regitser>{
  bool checkbool = false;
  bool sexbool = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          child: Stack(
            children: [
              Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/login.jpg'),fit: BoxFit.cover)),
                child: Flex(direction: Axis.vertical,children: [
                  Expanded(flex: 3,child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(icon: Icon(Icons.chevron_left),onPressed: (){},),
                              Text("SING IN",style: TextStyle(fontSize: 20),)
                            ],
                          ),
                          Expanded(child: Text("原野无边无际，远处的天空比近处的树林还要低；江水清清，明月仿似更与人相亲",maxLines: 2,))
                        ]
                    ),
                  ),),
                  Expanded(flex:7,child: Container(padding: EdgeInsets.all(20),child: Form(
                    child: Column(
                      children: [
                        TextFormField(key: UniqueKey(),maxLength: 13,maxLines: 1,decoration: InputDecoration(
                            icon: Icon(Icons.account_circle,color: Colors.blue,),
                            hintText: "请输入手机号码",
                            labelText: "手机号"
                        ),),
                        TextFormField(key: UniqueKey(),maxLength: 10,maxLines: 1,decoration: InputDecoration(
                            icon: Icon(Icons.account_circle,color: Colors.blue,),
                            hintText: "请输入用户名",
                            labelText: "用户名"
                        ),),
                        TextFormField(key: UniqueKey(),maxLength: 10,maxLines: 1,decoration: InputDecoration(
                            icon: Icon(Icons.account_circle,color: Colors.blue,),
                            hintText: "请输入面膜",
                            labelText: "密码"
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text("男"),
                          Switch(value: sexbool, onChanged: (value){
                            setState(() {
                              sexbool = value;
                            });
                          }),
                          Text("女")
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          MaterialButton(color: Colors.red,child: Text("注册"),onPressed: (){
//                            Request.setNetwork('user/', da)
                          },),
                          SizedBox(width: 10,),
                          MaterialButton(color: Colors.blue,child: Text("登录"),onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                          },),
                        ],)
                      ],
                    ),
                  ),)),
                ],),),
            ],
          ),
        ),
    );
  }
}



