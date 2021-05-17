import 'dart:io';

import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
class createGroup extends StatefulWidget {
  @override
  _createGroupState createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {

  List imageDynamic = [];
  int stateus=0;
  int clickColor=0;
  int radioGroup=1;
  bool switchValidation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _state = context.watch<GlobalState>();
    return Scaffold(
      appBar: AppBar(title: Text("创建团队"),),
      body: Container(
          width: _size.width,
          height: _size.height,
          child:Form(
              child: Column(
                children: [
                  TextFormField(decoration: InputDecoration(hintText: "请输入团队名称"),),
                  Row(children: [
                    Text("请上传团队封面",textAlign: TextAlign.start,)
                  ],),
                  upCover(),
                  TextFormField(decoration: InputDecoration(hintText: "请输入团队宣言"),),
                  Row(children: [
                    Text("团队类型",textAlign: TextAlign.start,)
                  ],),
                  Container(height: 40,child: checkTeamType(_size)),
                  Row(children: [Text("团队规模")],),
                  Row(
                    children: [
                      for(var i=0;i<3;i++)
                        radioWidget(i)
                    ],
                  ),
                  Row(children: [Text("是否开启验证"),Switch(value: switchValidation, onChanged: (value){
                    setState(() {
                      switchValidation = value;
                    });
                  })],),
                  Expanded(child: limitValidation(switchValidation)),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.creativeCommonsSa), label: Text("重置")),
                      ElevatedButton.icon(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.hardHat), label: Text("创建")),
                    ],
                  ))
                ],
              ))
      ),
    );
  }

//  限制性别，限制地区，限制等级，限制积分
  Widget limitValidation(bool validate){
    return validate?Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("地区限制"),
            Text("城市")
          ],),
        Row( mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Text("性别选择"),
          Switch(value: false, onChanged: (bool ?value){
          })
        ],),
        Row( mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text("等级"),Text("小于20级")],),
        Row( mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text("积分"),Text("大于30分")],),
      ],):Center(child: Text("您创建的团队任何人都可以加入"));
  }

//  上传团队封面
  Widget upCover(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for(var i=0;i<imageDynamic.length;i++)
          Container(
            width: MediaQuery.of(context).size.width/5,
            height: MediaQuery.of(context).size.width/4,
            margin: EdgeInsets.all(3),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image:DecorationImage(image: FileImage(File(imageDynamic[i])),fit: BoxFit.cover)
          ),),
        imageDynamic.length==4?Text(""):MaterialButton(
          onPressed: ()async{
            var reslut = await Creamer.GetGrally();
            print("得到的结果：${reslut}");
            setState(() {
              if(reslut !=null){
                imageDynamic.add(reslut);
                stateus=1;
                print("得到的图片内容：${imageDynamic}");
                print("得到的图片长度：${imageDynamic.length}");
              }
            });
          },
          child:Icon(Icons.add),
        )
      ],
    );
  }
//选择团队类型
  Widget checkTeamType(var _size){
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return  InkWell(
            onTap: (){
              setState(() {
                clickColor = index;
              });
            },
            child: Container(
              width: _size.width/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:clickColor==index?Colors.blue:Colors.red,
//                      image: DecorationImage(
//                        image: NetworkImage(_state.avator!),
//                        fit: BoxFit.cover
//                      )
              ),
              child:Center(child: Text("娱乐"),),
            ),
          );
        },separatorBuilder: (context,index){
      return SizedBox(width: 5,);
    }, itemCount: 10);
  }

//  团队规模选择
  Widget radioWidget(int i){
    return Row(
      children: [
        Radio(value:  i+1, groupValue: radioGroup, onChanged: (int ?value){
          setState(() {
            radioGroup =value! ;
          });
        }),
        Text("${i+1}00人"),
      ],
    );
  }
}

