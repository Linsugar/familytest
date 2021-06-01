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
      return Center(child:CircularProgressIndicator());
    }
  );
}

//
//class test01 extends StatefulWidget {
//  @override
//  _test01State createState() => _test01State();
//}
//
//class _test01State extends State<test01> with SingleTickerProviderStateMixin{
//  AnimationController ?animation;
//  double currentProgress = 0.6;
//  Tween<double> ?tween;
//  @override
//  void initState() {
//    animation = AnimationController(
//      // 这个动画应该持续的时间长短。
//      duration: const Duration(milliseconds: 900),
//      vsync: this,
//      // void addListener(
//      //   VoidCallback listener
//      // )
//      // 每次动画值更改时调用监听器
//      // 可以使用removeListener删除监听器
//    )..addListener(() {
//      setState(() {});
//    });
//    // Tween({T begin, T end })：创建tween（补间）
//    tween = Tween<double>(
//      begin: 0.0,
//      end: 1.0,
//    );
//    // 开始向前运行这个动画（朝向最后）
//    animation!.forward();
//    super.initState();
//  }
//  @override
//  Widget build(BuildContext context) {
//    print("${tween!.animate(animation!).value}");
//    return Container(
//      child: AnimatedBuilder(
//        animation:animation! ,
//        builder:(BuildContext context, Widget? child){
//          return Center(child:LinearProgressIndicator(value: tween!.animate(animation!).value,),);
//        } ,
//      ),
//    );
//  }
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    animation!.dispose();
//    super.dispose();
//  }
//}



