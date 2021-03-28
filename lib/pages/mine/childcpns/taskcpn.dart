import 'package:flutter/material.dart';
class task extends StatefulWidget{


  @override
  _taskState createState() => _taskState();
}

class _taskState extends State<task> with SingleTickerProviderStateMixin{

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
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(title: Text("任务大厅"),actions: [Popuitemwidget()],),
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
                    ListView.separated(itemBuilder: (context,index){
                      return ListTile(
                        leading: Text("${index}"),title: Text("今夜训练场200圈"),
                        subtitle: Text("今夜训练场200圈"*4),
                        trailing: Text("详情"),
                      );
                    }, separatorBuilder: (context,index){
                      return Divider();
                    }, itemCount:20),
                    RefreshIndicator(
                      onRefresh: (){
//                        print("刷新数据：${this._DataList}");
                        return data_3();
                      },
                      child: Container(
                        child:
                        Center(
                          child: FutureBuilder(
                            future: data_3(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              print("当前状态1：${snapshot.connectionState}");
                              print("当前状态1：${snapshot}");
                              if(snapshot.connectionState ==ConnectionState.waiting){
                                return CircularProgressIndicator();
                              }
                              if (snapshot.connectionState == ConnectionState.done) {
                                print("当前状态：${snapshot.data}");
                                if(snapshot.hasData){
                                  return ListView.separated(itemBuilder: (context,index){
                                    return ListTile(
                                      leading: Text("${index}"),title: Text("今夜训练场200圈"),
                                      subtitle: Text("今夜训练场200圈"*4),
                                      trailing: Text("详情"),
                                    );
                                  }, separatorBuilder: (context,index){
                                    return Divider();
                                  }, itemCount:snapshot.data.length);
                                }
                                else{
                                  return Text("Error:1");
                                }
                              }
                              else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
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


  Future data_3()async{

    var Data = Future.delayed(Duration(seconds: 3),(){
      List _DataList =[];
      for(var i=0;i<3;i++){
        _DataList.add(1);
      }
      return _DataList;
    });
    return await Data;
  }




}

class Popuitemwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.all(8),
        offset: Offset(0,5.0),
        onSelected: (value){
          print("选中的值:$value");
        },
        itemBuilder:(BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: '选项一的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.account_circle,color: Colors.lightBlue,),Text("添加好友")],)
          ),
          PopupMenuItem<String>(
              value: '选项二的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.search,color: Colors.lightBlue,),Text("搜索好友")],)

          )
        ]
    );
  }
}
