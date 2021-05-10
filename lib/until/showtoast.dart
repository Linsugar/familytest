
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class PopupUntil{
 static void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}

class loadingCircu extends StatelessWidget {
  loadingCircu(Future loads){
    this.loads= loads;
  }
  var loads;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loads,
        builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.connectionState ==ConnectionState.waiting){
        return CircularProgressIndicator();
      }else{
        return Container();
      }
    });
  }
}




ShowAlerDialog(context)async{
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("权限协议"),
      content: Container(
        child: Text(
           '欢迎使用"语论"!我们非常重视您的个人信息和隐私保护。在您使用"语论"服务之前,请仔细阅读《语论视频隐私政策》和《语论用户协议》,我们将严格按照经您同意的各项条款使用您的个人信息,以便为您提供更好的服务请您同意此政策和协议。'
        '请点击“同意"开始使用我们的产品和服务,我们将尽全力保护您的个人信息安全。'
            ''),
      ),
      actions: [
        MaterialButton(child: Text('取消'),onPressed: (){
          Navigator.pop(context);
        },),
        MaterialButton(child: Text('同意'),onPressed: (){
          PopupUntil.showToast("不好意思，我还没想好怎么做");
        },),
      ],
    );
  });
}


