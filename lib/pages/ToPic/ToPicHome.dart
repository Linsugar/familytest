import 'package:familytest/network/requests.dart';
import 'package:familytest/pages/chat/model/chatdynamic.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CommonUntil.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Topic extends StatefulWidget{
//  话题
  @override
  State<StatefulWidget> createState() =>TopicState();
}

class TopicState extends State<Topic> with SingleTickerProviderStateMixin{

  final List<Widget> _tabList = [Text("全部"),Text("娱乐"),Text("电竞"),Text("科技"),Text("奇文"),Text("健康"),Text("萌宠")];
  TabController ?_tabController;
  TextEditingController ?_textEditingController;
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  List ? wx;

  @override
  void initState() {
    // TODO: implement initState
    _getDynamic();
    _focusNode.unfocus();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _textEditingController =TextEditingController();
    super.initState();
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });
  }

  //  获取动态
  _getDynamic()async{
    print("进入获取动态");
    List dynamciList = [];
    var result = await Request.getNetwork('DyImage/',token:context.read<GlobalState>().userInfo['token']);
    result.forEach((value){
      dynamciList.add(chatdynamic(value));
      context.read<GlobalState>().changeDynamicList(dynamciList);
    });
    return dynamciList;
  }

  @override
  Widget build(BuildContext context) {
    wx = context.watch<GlobalState>().wxlist;
    List dataList = context.watch<GlobalState>().dynamicList;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("话题",),actions: [MaterialButton(onPressed: (){},child: Icon(Icons.account_circle),)],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(flex: 3,child: headerContent()),
            TabBar(
              labelPadding: EdgeInsets.all(5),
              labelColor: Colors.black,
              tabs: _tabList,
              controller: _tabController,
            ),
            Expanded(
              flex: 7,
              child: TabBarView(
                controller: _tabController,
                children: [
                  for(var i=0;i<7;i++)
                    titleCdk(dataList,i)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  //头部内容
  Widget headerContent(){
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

//话题文章
  Widget titleCdk(dataList,index){
    if(dataList == null){
      return Center(child: CircularProgressIndicator(),);
    }
    if(index == 0){
      return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':dataList[index]} );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5,child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(image: NetworkImage(dataList[index].imagelist[0]),fit: BoxFit.cover))
                  )),
                  SizedBox(width: 10,),
                  Expanded(flex: 5,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${dataList[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${dataList[index].con}",maxLines: 2,overflow: TextOverflow.ellipsis),
                          Text("${dataList[index].username}"),
                        ],),
                      SizedBox(height:10,),
                      Row(children: [
                        Icon(Icons.play_arrow),
                        Text("${551*index}"),
                        SizedBox(width: 20,),
                        Icon(Icons.star_border),
                        Text("${13*index*1+13}"),
                      ],)
                    ],
                  )),
                ],
              ),
            );
          }, separatorBuilder: (context,index){
        return Divider();
      }, itemCount: dataList.length);
    }
    else{
      index = index -1;
      var newData = dataList.where((value)=>value.Dynamic_Type == index).toList();
      return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':newData[index]} );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5,child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(image: NetworkImage(newData[index].imagelist[0]),fit: BoxFit.cover))
                  )),
                  SizedBox(width: 10,),
                  Expanded(flex: 5,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${newData[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${newData[index].con}",maxLines: 2,overflow: TextOverflow.ellipsis),
                          Text("${newData[index].username}"),
                        ],),
                      SizedBox(height:10,),
                      Row(children: [
                        Icon(Icons.play_arrow),
                        Text("${551*index}"),
                        SizedBox(width: 20,),
                        Icon(Icons.star_border),
                        Text("${13*index*1+13}"),
                      ],)
                    ],
                  )),
                ],
              ),
            );
          }, separatorBuilder: (context,index){
        return Divider();
      }, itemCount: newData.length);
    }
  }


}


