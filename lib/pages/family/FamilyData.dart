
import 'package:familytest/network/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Familymodel.dart';

class Family extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FamilyState();
  }
}

class FamilyState extends State<Family>{
  _getTeam()async{
    List<Familymodel> familyList = [];
   var _res = await Request.getNetwork('team/');
   _res.forEach((value){
     familyList.add(Familymodel(value));
   });
   return familyList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("团队",),actions: [MaterialButton(onPressed: (){},child: Icon(Icons.account_circle),)],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(flex: 3,child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 2,child:Container(margin: EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
                    IconButton(icon: Icon(Icons.add_circle), onPressed: (){}),
                  ],),
                )),
              Flexible(flex: 15,child: Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: ListView.separated(scrollDirection: Axis.horizontal,itemCount: 20,separatorBuilder: (context,index){
                  return SizedBox(width: 10,);
                },itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/childfamily');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/idcard.png'),fit: BoxFit.contain
                          )
                        ),width: 230),
                      ),
                    );
                },),
              ),)
              ],
            ),),
            Flexible(flex: 7,child: Container(
              margin: EdgeInsets.only(left: 30,right: 30,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(-1.0,2.0),spreadRadius: 2.0)],
                  borderRadius: BorderRadius.circular(10),),
                child: ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Container(child:Flex(direction: Axis.vertical,children: [
                      Flexible(flex: 2,child: Container(
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(0.0,3.0),color: Colors.deepPurpleAccent[100]!,blurRadius: 10.0)]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(decoration: BoxDecoration(color: Colors.deepPurpleAccent[100]),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                          ],),),
                        ),
                      )),
                      Flexible(flex: 1,child: Container(padding: EdgeInsets.all(10),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Text("展示热点"),
                        Text("全部"),
                      ],),),),
                      Flexible(flex: 7,child:FutureBuilder(future: _getTeam(),builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(snapshot.connectionState ==ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(),);
                        }if(snapshot.hasData){
                          List snp = snapshot.data;
                          return ListView.builder(itemCount: snp.length,itemBuilder: (context,index){
                            return ListTile(
                              onTap: (){
                                print("准备传入的参数${snp[index]}");
                                Navigator.pushNamed(context,'/childfamily',arguments: snp[index]);
                              },
                              leading: CircleAvatar(backgroundImage: NetworkImage(snp[index].teamCover[0]),),
                              title: Text("${snp[index].teamName}"),
                              subtitle: Text("创建于${snp[index].teamTime}，现任族长：${snp[index].teamInit}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                              trailing: Text("￥230.000"),);
                          });
                        }
                        else{
                          return Text("请稍后数据加载出现了一点问题");
                        }
                      },)),
                    ],)))),),
          ],
        ),
      ),
    );
  }
}



