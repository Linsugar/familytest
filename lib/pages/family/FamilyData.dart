
import 'package:familytest/network/requests.dart';
import 'package:familytest/until/CommonUntil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'model/Familymodel.dart';

class Family extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FamilyState();
  }
}

class FamilyState extends State<Family> with SingleTickerProviderStateMixin{
  _getTeam()async{
    List<Familymodel> familyList = [];
   var _res = await Request.getNetwork('team/');
   _res.forEach((value){
     familyList.add(Familymodel(value));
   });
   return familyList;
  }


  List<Widget> _tabList = [Text("慢性肾炎"),Text("高血压"),Text("心脏病"),Text("痛风"),Text("结石"),];
  TabController ?_tabController;
  TextEditingController ?_textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 5, vsync: this);
    _textEditingController =TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("话题",),actions: [MaterialButton(onPressed: (){},child: Icon(Icons.account_circle),)],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(flex: 3,child: Flex(
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
            Expanded(flex: 7,child: Column(
              children: [
                TabBar(
                  labelPadding: EdgeInsets.all(5),
                  labelColor: Colors.black,
                  tabs: _tabList,controller: _tabController,),
                homeInput(_textEditingController!),
                Expanded(flex: 6,child: TabBarView(
                  controller: _tabController,
                  children: [Text("1"),Text("1"),Text("1"),Text("1"),Text("1"),],
                )),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
