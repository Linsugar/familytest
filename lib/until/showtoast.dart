
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

