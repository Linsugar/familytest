import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:familytest/pages/login/register.dart';
import '../../main.dart';


class Login extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _fromglobalKey = GlobalKey<FormState>();
  TextEditingController _Usercontroller  =TextEditingController();
  TextEditingController _Pwdcontroller  =TextEditingController();
  String _file;
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    _file = 'assets/flag.riv';
    _createRive(_file);
  }
  void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              child:_riveArtboard == null ? const SizedBox() : Rive(artboard: _riveArtboard,fit: BoxFit.cover,),
            ),
            Positioned(top: 20,right: 20,child: MaterialButton(child: Text("注册",style: TextStyle(color: Colors.white),),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Regitser()));
            },)),
            Positioned(
              top: MediaQuery.of(context).size.height/3,
              left: 0,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child:Container(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _fromglobalKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: _Usercontroller,
                            keyboardType: TextInputType.phone,
                            maxLength: 13,
                            validator: (user){
                              if(user.isEmpty || user.length<5){
                                return "用户名有误";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "请输入手机号码",
                                icon: Icon(Icons.account_circle)),),
                          TextFormField(
                            validator: (pwd){
                              if(pwd.isEmpty || pwd.length<5){
                                return "密码有误";
                              }
                            },
                            obscureText: true,
                            keyboardType:TextInputType.number ,
                            controller: _Pwdcontroller,
                            decoration: InputDecoration(
                                hintText: "请输入用户名",
                                icon: Icon(Icons.add_call)),
                            maxLength: 15,
                          ),
                          Row
                            (mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                            ElevatedButton.icon(onPressed: ()async{
                              if( _fromglobalKey.currentState.validate()){
                                var userdata = {
                                  'user_mobile':_Usercontroller.text,
                                  'user_pwd':_Pwdcontroller.text
                                };
                               var loginResult =  await Request.getNetwork('user/',params: userdata);
                               print("返回结果：$loginResult");
                               if(loginResult['user_name'] !='' && loginResult['user_id'] !=''){
                                 print("验证通过");
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                     MainHome()));
                                 context.read<GlobalState>().changToken(false);
                               }else{
                                 showToast("您的账号密码有误！");
                               }

                              }else{
                                showToast("请正确输入内容，不要乱搞哦！");
                              }
                            }, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("登录")),
                            ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("注册"))
                          ],),
                        ],
                      ),
                    ),
                  ),

                ),
              ),),
          ],
        ),
      ),
    );
  }
  _createRive(_file){
    rootBundle.load(_file).then(
//      1.加载riv文件，
          (data) async {
//            创建一个存储rive二进制的文件
        final file = RiveFile();
        if (file.import(data)) {
          final artboard = file.mainArtboard;
//          添加一个控制器，随时进行控制动画
          artboard.addController(_controller = SimpleAnimation('flag'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }
}