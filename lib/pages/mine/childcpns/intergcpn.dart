import 'package:flutter/material.dart';
class interg extends StatefulWidget {
  @override
  _intergState createState() => _intergState();
}

class _intergState extends State<interg> {
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201506%2F07%2F20150607152403_imWHZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619914237&t=515f1d7509029c6c468eda87127712e1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的积分"),),
      body: Stack(
        children: [
          Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  Expanded(flex: 4,child: Container(color: Colors.green[100],child: Column(
                    children: [
                      Expanded(flex: 1,child: Container(color: Colors.green[100],)),
                      Expanded(flex: 3,child: Container(decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          image: DecorationImage(
                              image: NetworkImage(_imagrurl)
                          )
                      ),)),
                      Expanded(flex: 5,child: Container(color: Colors.green[100],
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [Text("经验值:329"),Text("距离升级:21")],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [Text("Lv.9"),Text("Lv.10")],),
                          ],
                        )
                        ,)),
                    ],
                  ),)),
                  Expanded(flex: 6,child: Container(color: Colors.white,)),
                ],
              )
          ),
          Positioned(left: 20,right: 20,top: MediaQuery.of(context).size.height/4,child: Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5)
            ),
            width: MediaQuery.of(context).size.width,
            height: 300,
            
          ))
        ],
      ),
    );
  }
}
