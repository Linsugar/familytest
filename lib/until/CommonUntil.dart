import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeInput(TextEditingController textController,FocusNode focusNode){
  return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white,width: 1.0)),
      padding: EdgeInsets.only(left: 10,right: 10),
      child:TextField(
        controller: textController,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search),suffixIcon: Icon(Icons.arrow_drop_down),hintText: '请输入搜索内容'),)
  );
}

void showLoading(context){
  showCupertinoDialog(
    context: context,
    builder: (_){
      return Center(child: CircularProgressIndicator());
    }
  );
}

