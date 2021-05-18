//团队管理


import 'dart:convert';
import 'package:familytest/pages/family/FamilyData.dart';
import 'package:familytest/pages/mine/model/family.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class familcpn extends StatefulWidget {
  @override
  _familcpnState createState() => _familcpnState();
}

class _familcpnState extends State<familcpn> {
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';

  @override
  void initState() {
//    _getJson();
    // TODO: implement initState
    super.initState();
  }

  _getJson()async{
    List<family> familist = [];
    var rs = await rootBundle.loadString('data/family.json');
    var rslut = jsonDecode(rs);
    rslut.forEach((value){
      print("rs$value");
      familist.add(family(value));
    });
    print("得到最终结果：$familist");
    return familist;
  }

  _Manger()async{
    List Mang = [];
    return Mang;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("团队"),),
      body: Container(
        child: FutureBuilder(
          future: _Manger(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }if(snapshot.hasData){
            List snd = snapshot.data;
            if(snd.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("您当前没有团队，请自行选择一个加入"),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        MaterialButton(child: Text("创建团队"),onPressed: (){
                          Navigator.pushNamed(context, '/createGroup');
                        }),
                        MaterialButton(child: Text("加入团队"),onPressed: (){
//
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Family()));
                        }),
                      ],
                    )
                  ],
                ),
              );
            }
            else{
              return Text("加入");

            }
          }
          else{
            return Center(child: Text("请稍后"),);
          }
        },),
      ),
    );
  }
}

