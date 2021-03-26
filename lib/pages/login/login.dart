import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/routes/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

//class Login extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    var _size = MediaQuery.of(context).size;
//    return Scaffold(
//      body:Container(
//        color: Colors.blue,
//        width: 600,
//        height: 600,
//        child: FlareActor(
//          'assets/buggy.riv',
//          animation: 'idle',
//          fit: BoxFit.cover,
//          alignment: Alignment.center,
//        ),
//      )
//    );
//  }
//}
//
//class loginwi extends StatelessWidget {
//  const loginwi({
//    Key key,
//    @required Size size,
//  }) : _size = size, super(key: key);
//
//  final Size _size;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(40),
//      width: _size.width,
//      height: _size.height,
//      decoration: BoxDecoration(image: DecorationImage(image:AssetImage('images/login.jpg'),fit: BoxFit.cover )),
//      child: Flex(
//        direction: Axis.vertical,
//        children: [
//          Expanded(
//            flex: 2,
//            child: Text("GoTravel",style: TextStyle(fontSize: 30),),
//          ),
//          Expanded( flex: 2,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                Text("原野无边无际，远处的天空比近处的树林还要低；江水清清，明月仿似更与人相亲",style: TextStyle(fontSize: 17),),
//                Text("原野无边无际，远处的天空比近处的树林还要低；江水清清，明月仿似更与人相亲",style: TextStyle(fontSize: 15),),
//              ],
//            )),
//          Flexible( flex: 3,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//               Text("登录界面"),
//               Container(width: _size.width/2 ,child: RaisedButton(onPressed: (){
//                 Application.router.navigateTo(context, '/register');
//               },child: Text("登录"),color: Colors.red,)),
//               Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//                      Container(width: _size.width/5,height: 1,color: Colors.white,),
//                      Text("GIF"),
//                      Container(width: _size.width/5,height: 1,color: Colors.white,)
//                    ],),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Container(color: Colors.white,child: IconButton(icon: Icon(Icons.star),onPressed: (){},)),
//                      SizedBox(width: 10,),
//                      Container(color: Colors.white,child: IconButton(icon: Icon(Icons.router),onPressed: (){},)),
//                    ],
//                  ),
//                  SizedBox(height: 10,),
//                  Text("水中可居者曰洲，小洲曰渚。")
//                ],
//              ),
//            ),
//        ],
//      )
//    );
//  }
//}


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
            Positioned(
              top: MediaQuery.of(context).size.height-400,
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
                            ElevatedButton.icon(onPressed: (){
                              if( _fromglobalKey.currentState.validate()){
                                context.read<GlobalState>().changToken(false);
                                Application.router.navigateTo(context, '/MainHome',replace: true);
                                print("验证通过");
                              }else{
                                setState(() {
                                  _Usercontroller.text="";
                                  _Pwdcontroller.text ="";
                                });
                                print("验证不通过");
                                Fluttertoast.showToast(
                                    msg: "您输入的内容有误哦",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("登录")),
                            ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.audiotrack,color: Colors.red,), label: Text("注册"))
                          ],),
                        ],
                      ),
                    ),
                  ),

    ),
              ),)
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