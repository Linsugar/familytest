import 'package:flutter/material.dart';
class task extends StatefulWidget{


  @override
  _taskState createState() => _taskState();
}

class _taskState extends State<task> with SingleTickerProviderStateMixin{
  List<dynamic> _DataList = [];
  TabController _tabController;
  TextStyle _textStyle = TextStyle(color: Colors.blue,fontSize: 20);
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync:this);
    _tabController.addListener(() {
      print("当前下标：${_tabController.index}");
    });
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    this._DataList.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("任务大厅"),),
        body:Container(
            constraints: BoxConstraints.expand(),
            child: Flex(direction: Axis.vertical,children: [
              Flexible(flex: 0,child: Container(
                color: Colors.cyan,
                child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Text("初级",style: _textStyle),
                      Text("VIP",style: _textStyle),
                      Text("SVIP",style:_textStyle),
                    ] ),
              )),
              Flexible(flex: 9,child: Container(child:
              TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(itemCount: 20,itemBuilder: (context,index){
                      return ListTile(
                        leading: Text("$index"),title: Text("今夜训练场200圈"),
                        subtitle: Text("今夜训练场200圈"*4),
                        trailing: Text("详情"),);
                    }),
                    RefreshIndicator(
                      onRefresh: (){
                        print("刷新数据：${this._DataList}");
                        return data_s();
                      },
                      child: Container(
                        child:
                        FutureBuilder(
                          future: data_s(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              print("当前状态：${snapshot.connectionState}");
                              print("当前状态：${snapshot.data}");
                              if(this._DataList.isEmpty){
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Text("Error:1");
                              } else {
                                return ListView.separated(itemBuilder: (context,index){
                                  return ListTile(
                                    leading: Text("${index}"),title: Text("今夜训练场200圈"),
                                    subtitle: Text("今夜训练场200圈"*4),
                                    trailing: Text("详情"),
                                  );
                                }, separatorBuilder: (context,index){
                                  return Divider();
                                }, itemCount: this._DataList.length);
                              }
                            }
                            else {
                              return CircularProgressIndicator();
                            }
                          },
                        ) ,
                      ),
                    ),
                    Text("SVIP",style:_textStyle),
                  ]),
              )),
            ],)
        )
    );
  }


  Future data_s()async{
    Future.delayed(Duration(seconds: 2),(){
      for(var i=0;i<3;i++){
        this._DataList.add(i);
      }
    });
    return this._DataList;
  }
}
