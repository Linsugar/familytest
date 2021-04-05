import 'dart:convert';

import 'package:familytest/pages/mine/model/family.dart';
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
    _getJson();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("职位"),),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(flex: 2,child: Container(width: double.infinity,decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_imagrurl),
                  ),
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 3.0,offset: Offset(-1.0,0.8))]
                ),)),
                Expanded(flex: 8,child: Container(color: Colors.blue,)),
              ],
            ),
          ),
          Positioned(left: 10,right: 10,top: MediaQuery.of(context).size.height/7,
              child: Container(
                height: MediaQuery.of(context).size.height,decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),child: Align(
                alignment: Alignment.topCenter,
                child: FutureBuilder(
                  future: _getJson(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.connectionState ==ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{
                      if(snapshot.hasError){
                        return Icon(Icons.error);
                      }else{
                        return DataTable(
                          onSelectAll: (value){
                            print("表头value:$value");
                          },
                          columns: [
                            DataColumn(label:Text("职位")),
                            DataColumn(label:Text("积分")),
                          ],
                          rows: [
                            for(var i=0;i<snapshot.data.length;i++)
                              DataRow(cells: [
                                DataCell(Text("${snapshot.data[i].familyname}")),
                                DataCell(Text("${snapshot.data[i].familystatue}")),],
                                selected:snapshot.data[i].familybool,
                                onSelectChanged: (value){
                                  print("表单value:$value");
                                }
                              ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),))
        ],

      ),
    );
  }
}

