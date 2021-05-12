import 'dart:io';

import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/CreamUntil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class createGroup extends StatefulWidget {
  @override
  _createGroupState createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  List imageDynamic = [];
  int stateus=0;
  int checkcolor=0;
  int grval=1;
  bool switchbol = false;
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
            Row(
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
            ),
            TextFormField(decoration: InputDecoration(hintText: "请输入团队宣言"),),
            Row(children: [
              Text("团队类型",textAlign: TextAlign.start,)
            ],),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                return  InkWell(
                  onTap: (){
                    setState(() {
                      checkcolor = index;
                    });
                  },
                  child: Container(
                    width: _size.width/4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                        color:checkcolor==index?Colors.blue:Colors.red,
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
                  }, itemCount: 10),
            ),
            Row(children: [Text("团队规模")],),
              Row(
                children: [
                Row(
                  children: [
                    Radio(value: 1, groupValue:grval, onChanged: (Rvalue){
                      print("当前值：${Rvalue.runtimeType}");
                      setState(() {
                        grval =int.parse(Rvalue.toString()) ;
                      });
                    }),
                    Text("100人"),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 2, groupValue: grval, onChanged: (Rvalue){
                      print("当前值：${Rvalue.runtimeType}");
                      setState(() {
                        grval =int.parse(Rvalue.toString()) ;
                      });
                    }),
                    Text("200人"),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 3, groupValue: grval, onChanged: (Rvalue){
                      print("当前值：${Rvalue.runtimeType}");
                      setState(() {
                        grval =int.parse(Rvalue.toString()) ;
                      });
                    }),
                    Text("300人"),
                  ],
                ),
                ],
              ),
            Row(children: [Text("是否开启验证"),Switch(value: switchbol, onChanged: (value){
              setState(() {
                switchbol = value;
              });
            })],),
              Expanded(flex: 7,child: Container(color: Colors.blue,)),

          ],
        ))
      ),
    );
  }
}

class radiowidet extends StatefulWidget {
   int _value;
   int _person;
   int  grval;
  radiowidet(
      this._value,this._person,this.grval
      );

  @override
  _radiowidetState createState() => _radiowidetState();
}

class _radiowidetState extends State<radiowidet> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: widget._value, groupValue: widget.grval, onChanged: (Rvalue){
          print("当前值：${Rvalue.runtimeType}");
          setState(() {
            widget.grval =int.parse(Rvalue.toString()) ;
          });
        }),
        Text("${widget._person}人"),
      ],
    );
  }
}


