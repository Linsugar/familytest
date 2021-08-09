import 'package:familytest/network/requests.dart';
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

  List<Widget> _tabList = [Text("娱乐"),Text("健康"),Text("电竞"),Text("大海"),Text("田野"),];
  TabController ?_tabController;
  TextEditingController ?_textEditingController;
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  List ? wx;

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
    wx = context.watch<GlobalState>().wxlist;
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
            headerContent(),
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
                    children: [titleCdk(),titleCdk(),titleCdk(),titleCdk(),titleCdk(),],
                  )),
                ],
              ),
            ),
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

//肾炎文章
  Widget titleCdk(){
    return ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/webviewcpns',arguments: {
                "wxcontext":wx![index]
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5,child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: NetworkImage(wx![index].wxphoto),fit: BoxFit.cover))
                )),
                SizedBox(width: 10,),
                Expanded(flex: 5,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${wx![index].wxtitle}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
                    SizedBox(height:10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${wx![index].wxdigest}",maxLines: 2,overflow: TextOverflow.ellipsis),
                        Text("${wx![index].wxauthor}"),
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
    }, itemCount: wx!.length);
  }


}


