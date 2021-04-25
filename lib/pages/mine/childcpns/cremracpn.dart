
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

import 'getdynamic.dart';

class cremacpn extends StatefulWidget {
  @override
  _cremacpnState createState() => _cremacpnState();
}

class _cremacpnState extends State<cremacpn> {
  var imagefile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getUserdynamic()async{
    List<dynamicdata> dy =[];
    print("进入请求");
   var result = await Request.getNetwork('DyImage/',params: {
      'user_id':context.read<GlobalState>().userid
    },token:context.read<GlobalState>().logintoken );
   result.forEach((value){
       dy.add(dynamicdata(value));
   });
   return dy;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("动态"),actions: [MaterialButton(onPressed: ()async{
         var sqlpath =  await getDatabasesPath();
         print("获取地址：$sqlpath");
        },
          child: GestureDetector(onTap: (){
            Navigator.pushNamed(context, '/updynamic');
          },child: Text("发布动态")),)],),
        body:Container(
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future:_getUserdynamic(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print('状态：${snapshot.data}');
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Center(child: Text("产生了一点小问题，请稍后"),);
              }
              if(snapshot.data.isEmpty){
                return Center(child: Text("您当前还未发布动态哟~"),);
              }
              else{
                return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,index){
                  return ExpansionTile(title: Align(alignment: Alignment.topLeft,child: Text("${snapshot.data[index].title}")),children: [
                    Container(
                      height: MediaQuery.of(context).size.height/5,
                      child: Column(
                        children: [
                          Expanded(flex: 5,child: Padding(padding: EdgeInsets.all(10),child: Text("${snapshot.data[index].context}"))),
                          Expanded(flex: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                            for(var i=0;i<snapshot.data[index].imageurl!.length;i++)
                                  Container(width: MediaQuery.of(context).size.width/4.5,height: MediaQuery.of(context).size.width/5,child: Image(image: NetworkImage(snapshot.data[index].imageurl![i]),fit: BoxFit.cover,))
                          ],)),
                        ],
                      ),
                    )
                  ],);
                });
              }
            },
          )
        )
    );
  }
}


//ListTile(
//leading: Text("$index"),
//title:  Text("${dy[index].context}"),
//subtitle: Flex(direction: Axis.horizontal,children: [

//],),
//trailing: MaterialButton(onPressed: (){},child: Text("查看")))