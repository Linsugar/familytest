
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/TaskState.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



_TaskHistory(int ?statue,context)async{
  var result = await Request.getNetwork('/taskonly/',params: {
    'taststatue':statue=null,
    'taskid':Provider.of<GlobalState>(context,listen: false).userid
  });
  Provider.of<taskState>(context,listen: false).changeTask(result);
  return result;
}

class task extends StatefulWidget{
  @override
  _taskState createState() => _taskState();
}

class _taskState extends State<task> with SingleTickerProviderStateMixin{

  TabController ?_tabController;
  TextStyle _textStyle = TextStyle(color: Colors.blue,fontSize: 20);
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync:this);
    _tabController?.addListener(() {
      print("当前下标：${_tabController?.index}");
    });
    super.initState();
  }
  @override
  void dispose() {
    _tabController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  

_getTaskcls(int taskcls,int taststatu)async{
 var result = await Request.getNetwork('/sendtask/',params: {
    'taskcls':taskcls,
    'taststatue':taststatu
  });
 Provider.of<taskState>(context,listen: false).changeTask(result);
 return result;
}



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("任务大厅"),actions: [MaterialButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GetManger(_TaskHistory(null,context))));
        },child: Text("领取记录"),)],),
        body:Container(
            constraints: BoxConstraints.expand(),
            child: Flex(direction: Axis.vertical,children: [
              Flexible(flex: 0,child: Container(
                child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Text("初级任务",style: _textStyle),
                      Text("中级任务",style: _textStyle),
                      Text("高级任务",style:_textStyle),
                    ] ),
              )),
              Flexible(flex: 9,child: Container(child:
              TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: Center(
                        child: Futurwiget(_getTaskcls(1,1),),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: (){
//                        print("刷新数据：${this._DataList}");
                        return _getTaskcls(2,2);
                      },
                      child: Container(
                        child:
                        Center(
                          child: Futurwiget(_getTaskcls(2,1)),
                        ) ,
                      ),
                    ),
                    Container(
                      child:
                      Center(
                        child: Futurwiget(_getTaskcls(3,1)),
                      ) ,
                    ),
                  ]),
              )),
            ],)
        )
    );
  }

}


class Popuitemwidget extends StatefulWidget {
  @override
  _PopuitemwidgetState createState() => _PopuitemwidgetState();
}

class _PopuitemwidgetState extends State<Popuitemwidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.all(8),
        offset: Offset(0,5.0),
        onSelected: (value){
          print("选中的值:$value");
          setState(() {
            _TaskHistory(2,context);
          });

        },
        itemBuilder:(BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: '选项一的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.account_circle,color: Colors.lightBlue,),Text("仅看已完成")],)
          ),
          PopupMenuItem<String>(
              value: '选项二的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.search,color: Colors.lightBlue,),Text("仅看未完成")],)
          )
        ]
    );
  }
}



class Futurwiget extends StatefulWidget {
  var data;
  Futurwiget(this.data);

  @override
  _FuturwigetState createState() => _FuturwigetState();
}

class _FuturwigetState extends State<Futurwiget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:widget.data,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print("当前状态1：${snapshot.connectionState}");
        print("当前状态1：${snapshot}");
        if(snapshot.connectionState ==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("当前状态：${snapshot.data}");
          if(snapshot.hasData){
            var snda = context.watch<taskState>().tasklist;
            return ListView.separated( itemCount:snda.length,itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                },
                child: Dismissible(
                  key: ValueKey(index),
                  child: ListTile(
                    leading: Text("${index+1}"),title: Text("${snda[index]['tasktitle']}"),
                    subtitle: Text("${snda[index]['taskcontent']}"),
                    trailing: MaterialButton(child: Text(snda[index]['taststatue']==1?'领取':(snda[index]['taststatue']==2?'已领取':'已完成')),onPressed: (){},),
                  ),
                ),
              );
            }, separatorBuilder: (context,index){
              return Divider();
            });
          }
          else{
            return Text("Error:1");
          }
        }
        else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
//领取记录
class GetManger extends StatefulWidget {
  var data;
  GetManger(this.data);

  @override
  _GetMangerState createState() => _GetMangerState();
}

class _GetMangerState extends State<GetManger> {
  @override
  Widget build(BuildContext context) {
    var taskhiy =_TaskHistory(null, context);
    return Scaffold(
      appBar: AppBar(title: Text("领取记录"),actions: [Popuitemwidget()],),
      body: Container(
        child: Center(
          child: Futurwiget(taskhiy),
        ),
      ),
    );
  }
}


