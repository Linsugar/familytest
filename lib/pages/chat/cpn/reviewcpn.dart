import 'package:flutter/material.dart';
class reviewCpn extends StatefulWidget {
  Map ?arguments;
  reviewCpn(this.arguments);
  @override
  _reviewCpnState createState() => _reviewCpnState();
}

class _reviewCpnState extends State<reviewCpn> {
  var data;
  @override
  void initState() {
    // TODO: implement initState
    data = widget.arguments!['data'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("详情"),),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(flex: 5,child:Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(data.avator),),
                  title: Text("${data.title}"),
                  subtitle:  Text("发布时间:${data.time}"),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      minHeight: 10,
                    ),
                    child:  Text("${data.con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
                ),
                SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  child:Column(
                    children: [
                      Expanded(flex: 3,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,im){
                              return Container(
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(data.imagelist[im]),
                                        fit: BoxFit.cover
                                    )
                                ),
                                width: 80,
                              );
                            }, separatorBuilder: (context,im){
                          return SizedBox(width: 5,height: 5,);
                        }, itemCount:data.imagelist.length),
                      ),
                    ],
                  ) ,
                )
              ],
            ),
          )),
          Expanded(flex: 5,child: Container(color: Colors.white30,)),
        ],
      ),
    );
  }
}
