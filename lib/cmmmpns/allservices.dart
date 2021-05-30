import 'package:flutter/material.dart';

class AllServices extends StatefulWidget {
  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4, child: Scaffold(
      appBar: AppBar(title: Text("所有服务"),backgroundColor: Colors.orange,iconTheme: IconThemeData(color: Colors.white),
      bottom: TabBar(
        isScrollable: true,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 15),
          tabs: [
        Text("康复师"),
        Text("医生管理"),
        Text("营养师管理"),
        Text("保险"),
      ]),),
      body: TabBarView(children: [
        Container(
          child: Column(
            children: [
              Row(children: [Text("服务期："),Text("2021/05/11-2021/05/17")],),
              Row(children: [Text("康复师："),Text("小雪 康复师")],),
              Row(children: [Text("所属套餐："),Text("赠送康复师")],),
              Row(children: [Text("状态："),Text("已经结束")],),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Row(children: [Text("服务期："),Text("2021/05/11-2021/05/17")],),
              Row(children: [Text("康复师："),Text("小雪 康复师")],),
              Row(children: [Text("所属套餐："),Text("赠送康复师")],),
              Row(children: [Text("状态："),Text("已经结束")],),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Row(children: [Text("服务期："),Text("2021/05/11-2021/05/17")],),
              Row(children: [Text("康复师："),Text("小雪 康复师")],),
              Row(children: [Text("所属套餐："),Text("赠送康复师")],),
              Row(children: [Text("状态："),Text("已经结束")],),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Row(children: [Text("服务期："),Text("2021/05/11-2021/05/17")],),
              Row(children: [Text("康复师："),Text("小雪 康复师")],),
              Row(children: [Text("所属套餐："),Text("赠送康复师")],),
              Row(children: [Text("状态："),Text("已经结束")],),
            ],
          ),
        ),
      ]),
    ));
  }
}
