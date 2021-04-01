import 'package:flutter/material.dart';
class interg extends StatefulWidget {
  @override
  _intergState createState() => _intergState();
}

class _intergState extends State<interg> {
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的积分"),),
      body: Container(
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
    );
  }
}
