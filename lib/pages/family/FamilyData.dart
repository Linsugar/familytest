
import 'package:familytest/network/requests.dart';
import 'package:familytest/until/CommonUntil.dart';
import 'package:familytest/until/showtoast.dart';
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
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.unfocus();
    _tabController = TabController(length: 5, vsync: this);
    _textEditingController =TextEditingController();
    super.initState();
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("话题",),actions: [MaterialButton(onPressed: (){},child: Icon(Icons.account_circle),)],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            headerContent(context),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelPadding: EdgeInsets.all(5),
                    labelColor: Colors.black,
                    tabs: _tabList,controller: _tabController,),
                  homeInput(_textEditingController!,_focusNode),
                  Expanded(flex: 6,child: TabBarView(
                    controller: _tabController,
                    children: [titleCdk(_scrollController),titleCdk(_scrollController),titleCdk(_scrollController),titleCdk(_scrollController),titleCdk(_scrollController),],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//头部内容
Widget headerContent(context){
  return Container(
    height: 150,
    width: MediaQuery.of(context).size.width,
    child: ListView.separated(scrollDirection: Axis.horizontal,itemCount: 20,separatorBuilder: (context,index){
      return SizedBox(width: 10,);
    },itemBuilder: (context,index){
      return GestureDetector(
        onTap: (){
          PopupUntil.showToast("该功能正在开发中");
//                        Navigator.pushNamed(context, '/childfamily');
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
  );
}

//肾炎文章
Widget titleCdk(_scrollController){
  String _imageUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F02%2F112809qybz22ltn8ybxt2x.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624344471&t=946bad365fde68214402444d79c26577';
  return ListView.separated(
    controller: _scrollController,
    padding: EdgeInsets.only(top: 10),
      itemBuilder: (context,index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5,child: Container(
            margin: EdgeInsets.only(left: 10),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: NetworkImage(_imageUrl),fit: BoxFit.cover))
          )),
        SizedBox(width: 10,),
        Expanded(flex: 5,child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1/7的美国成人患慢性肾病?看看美国专家如何支招！",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
            SizedBox(height:10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("压一压医生团"),
              Text("压一压"),
            ],),
            SizedBox(height:10,),
            Row(children: [
              Icon(Icons.play_arrow),
              Text("551"),
              SizedBox(width: 20,),
              Icon(Icons.star_border),
              Text("0"),
            ],)
          ],
        )),
      ],
    );
  }, separatorBuilder: (context,index){
    return Divider();
  }, itemCount: 20);
}