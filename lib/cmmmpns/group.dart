import 'dart:io';

import 'package:dio/dio.dart';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
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
  bool sexSelection = false;
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _TeamNamecontroller = TextEditingController();
  TextEditingController _TeamIntroductioncontroller = TextEditingController();
  var level = ['不限制','大于0~10','大于10~30','大于30~50','大于50~'];
  var score = ['不限制','大于20','大于50','大于70','大于90'];
  List<Widget> levelPoint = [];
  List<Widget> scorePoint = [];
  var currentlevel;
  var currentscore;


  @override
  void initState() {
    // TODO: implement initState
    levelPoint =level.map((e) => Text("$e")).toList();
    scorePoint =score.map((e) => Text("$e")).toList();
    currentscore=score[0];
    currentlevel=level[0];
    super.initState();
  }

  _createTeam()async{
    var data = FormData.fromMap({
      'Team_name':_TeamNamecontroller.text,
      'Team_init':context.read<GlobalState>().username,
      'Team_Type':"娱乐",
      'Team_Cover':[],
      'Team_Introduction':_TeamIntroductioncontroller.text,
      'Team_Size':radioGroup+00,
      'Team_City':Null,
      'Team_Score':Null,
      'Team_sex':sexSelection?'女':'男',
    });
    for(var i=0;i<imageDynamic.length;i++){
      data.files.add(
          MapEntry('Team_Cover',
              await MultipartFile.fromFile(imageDynamic[i])
          )
      );
    }
    var _res =await Request.setNetwork('team/', data);
    print("返回结果：$_res");
  }

//  重置数据
 void _rest(){
    _TeamIntroductioncontroller.text = '';
    _TeamNamecontroller.text = '';
     imageDynamic = [];
     stateus=0;
     clickColor=0;
     radioGroup=1;
     switchValidation = false;
 }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _state = context.watch<GlobalState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("创建团队"),),
      body: Container(
          width: _size.width,
          height: _size.height,
          child:Form(
              key: _globalKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _TeamNamecontroller,
                    validator: (value){
                      if(value!.isEmpty || value.length>10){
                        return "请输入符合要求的团队名称";
                      }return null;
                    },
                    decoration: InputDecoration(hintText: "请输入团队名称"),),
                  Row(children: [
                    Text("请上传团队封面",textAlign: TextAlign.start,)
                  ],),
                  upCover(),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty || value.length<10 ||value.length>30){
                        return "请输入符合要求的团队宣言";
                      }return null;
                    },
                    controller: _TeamIntroductioncontroller,
                    decoration: InputDecoration(hintText: "请输入团队宣言"),),
                  Row(children: [
                    Text("团队类型",textAlign: TextAlign.start,)
                  ],),
                  Container(height: 40,child:TeamType(_size)),
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
                      ElevatedButton.icon(onPressed: (){
                        setState(() {
                          _rest();
                        });
                      }, icon: FaIcon(FontAwesomeIcons.creativeCommonsSa), label: Text("重置")),
                      ElevatedButton.icon(onPressed: (){
                        if(_globalKey.currentState!.validate()){
                          _createTeam();
                          PopupUntil.showToast("创建成功，请稍后");
                          Navigator.popAndPushNamed(context, '/familcpn');
                        }

                      }, icon: FaIcon(FontAwesomeIcons.hardHat), label: Text("创建")),
                    ],
                  ))
                ],
              ))
      ),
    );
  }

//  城市选择器
   _citySlect()async{
    showDialog(context: context, builder: (context){
      return Dialog(child: Container(width: 100,height: 150,child: ListView.separated(itemBuilder: (context,index){
        return Center(child: Text("成都$index"));
      }, separatorBuilder: (context,index){
        return Divider();
      }, itemCount: 100),),);
    });
  }

  _showPicker(int p)async{
    showCupertinoModalPopup(context: context, builder: (context){
      return Container(
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(flex: 7,child: CupertinoPicker(itemExtent: 30, onSelectedItemChanged: (value){
              print("选择$value");
              if(p==0){
                setState(() {
                  currentlevel = level[value];
                });
              }else{
                setState(() {
                  currentscore = score[value];
                });
              }

            }, children:p==0?levelPoint:scorePoint)),
            Expanded(flex:3,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.account_circle), label: Text("重置")),
              ElevatedButton.icon(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.account_circle), label: Text("确定")),
            ],))
          ],
        ),
      );
    });
  }


//  限制性别，限制地区，限制等级，限制积分
  Widget limitValidation(bool validate){
    return validate?Table(
      children: [
        TableRow(
            children: [
              Text("地区"),
              Row(children: [
                Text("城市"),
                InkWell(onTap: (){
                  _citySlect();
                },child: FaIcon(FontAwesomeIcons.city))
              ],),
            ]
        ),
        TableRow(children: [
          Text("性别选择"),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.male,color: sexSelection?Colors.black:Colors.blue,),
              Switch(value: sexSelection, onChanged: (bool ?value){
                setState(() {
                  sexSelection=value!;
                });
              }),
              FaIcon(FontAwesomeIcons.female,color: sexSelection?Colors.blue:Colors.black,),
            ],)]),
        TableRow(
            children: [Text("等级"),InkWell(onTap: (){
              _showPicker(0);
            },child: Row(children: [Text("等级：$currentlevel"),FaIcon(FontAwesomeIcons.database)],))]
        ),
        TableRow(
            children: [Text("积分"),InkWell(onTap: (){
              _showPicker(1);
            },child: Row(children: [Text("积分：$currentscore"),FaIcon(FontAwesomeIcons.paw)],))]
        ),
      ],
    ):Center(child: Text("您创建的团队任何人都可以加入"));
  }

  Widget testTable(){
    return Table(
      children: [
        TableRow(
          children: [
            Text("地区"),
            Row(children: [
              Text("城市"),
              InkWell(onTap: (){
                _citySlect();
              },child: FaIcon(FontAwesomeIcons.city))
            ],),
          ]
        ),
        TableRow(children: [
          Text("性别选择"),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.male,color: sexSelection?Colors.black:Colors.blue,),
              Switch(value: sexSelection, onChanged: (bool ?value){
                setState(() {
                  sexSelection=value!;
                });
              }),
              FaIcon(FontAwesomeIcons.female,color: sexSelection?Colors.blue:Colors.black,),
            ],)]),
        TableRow(
          children: [Text("等级"),InkWell(onTap: (){
            _showPicker(0);
          },child: Row(children: [Text("等级：$currentlevel"),FaIcon(FontAwesomeIcons.database)],))]
        ),
        TableRow(
          children: [Text("积分"),InkWell(onTap: (){
            _showPicker(1);
          },child: Row(children: [Text("积分：$currentscore"),FaIcon(FontAwesomeIcons.paw)],))]
        ),
      ],
    );
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
  Widget TeamType(var _size){
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
          print("团队规模选择：$value");
          setState(() {
            radioGroup =value! ;
          });
        }),
        Text("${i+1}00人"),
      ],
    );
  }
}

