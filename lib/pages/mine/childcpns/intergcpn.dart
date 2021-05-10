//我的积分页面

import 'package:familytest/provider/grobleState.dart';
import 'package:provider/provider.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class interg extends StatefulWidget {
  @override
  _intergState createState() => _intergState();
}

class _intergState extends State<interg> {
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F07%2F20150607152403_imWHZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619914237&t=515f1d7509029c6c468eda87127712e1';
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    _scrollController.addListener(() {
      if(_scrollController.offset == _scrollController.position.maxScrollExtent){
        PopupUntil.showToast("已经到底了,不要再翻了，翻也翻不出个花儿出来");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的积分"),),
      body:Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(flex: 2,child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(112,182, 3, 1),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(112, 182, 3,0.6),spreadRadius:1.2,blurRadius: 1.5)]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("当前信用积分",style: TextStyle(fontSize: 20,color: Colors.white),),
                        SizedBox(height: 10,),
                        Text("97",style: TextStyle(fontSize: 20,color: Colors.white))
                      ],
                    ),
                    ClipOval(child: Image(image: NetworkImage(context.watch<GlobalState>().avator!),fit: BoxFit.cover,),)
                  ],
                ),
              ),
            )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(FontAwesomeIcons.exclamationCircle,color: Colors.red,size: 15,),
                SizedBox(width: 5,),
                Text("积分≤20分，帐号将被永久封禁、积分清零、禁止操作",style: TextStyle(fontSize: 10),)
              ],),
            Divider(),
            Expanded(flex: 8,child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("积分处罚记录",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
                  Divider(),
                  Expanded(child:ListView.separated(
                    controller: _scrollController,
                      itemBuilder: (context,index){
                    return Container(
                      child: Row(
                        children: [
                          Expanded(flex: 7,child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("2020-07-15"),
                              Text("歧视抵制/谩骂用户歧视抵制/谩骂用户歧视",maxLines: 2,overflow: TextOverflow.ellipsis,),
                            ],
                          )),
                          SizedBox(width: 10,),
                          Expanded(flex: 3,child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("积分：- X"),
                              Text("封禁：Y小时"),
                              Text("罚款：Z 元"),
                            ],
                          )),
                        ],
                      ),
                    );
                  }, separatorBuilder: (context,index){
                    return Divider();
                  }, itemCount: 20))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
