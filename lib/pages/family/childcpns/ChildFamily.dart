
import 'package:familytest/pages/TestCanvans/cantest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class childfamily extends StatefulWidget{
  var arguments;
  childfamily(this.arguments);
  @override
  State<StatefulWidget> createState() => childfamilystate();
}

class childfamilystate extends State<childfamily>{
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';
  ScrollController _ctl = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    print("得到的参数：${widget.arguments}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("${widget.arguments.teamName}"),),
      body: CustomScrollView(
        controller: _ctl,
        slivers: [
          SliverPersistentHeader(delegate: Mysliverheader(_imagrurl,widget.arguments),),
          Sliverbody(imagrurl: _imagrurl,),
          SliverToBoxAdapter(
            child: LineChartSample3(),
          ),
          SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
              (context,index){
                return MychildList(imagrurl: _imagrurl);
              },childCount: 10
          ), itemExtent: 80.0),],
      )
    );
  }
}

class Sliverbody extends StatelessWidget {
  const Sliverbody({
    Key ?key,
    @required String ?imagrurl,
  }) : _imagrurl = imagrurl, super(key: key);

  final String ?_imagrurl;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(height: 100,child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        OutlinedButton.icon(style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.deepPurpleAccent[100]) ) ,
            onPressed: (){
              showModalBottomSheet(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20) )) ,
                  context:context,
                  builder:(BuildContext context){
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),)
                      ),
                      height: 180,
                      child:Flex(direction: Axis.vertical,children: [
                        Flexible(flex: 2,child: Text("族内权势滔天之人")),
                        Flexible(flex: 8,child: ListView.builder(itemCount: 3,itemBuilder: (context,index){
                          return Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20) )) ,
                            child: ListTile(
                              leading: CircleAvatar(backgroundImage: NetworkImage(_imagrurl!),),
                              title: Text("族长"),
                              subtitle: Text("九眼妖王"),
                              trailing: Text("积分：158423"),
                            ),);
                        })),
                      ],)
                    );
                  }
              );
            }, icon:Icon(Icons.build), label: Text("小学生",style: TextStyle(color: Colors.white),)),
        SizedBox(width: 10,),
        OutlinedButton.icon(onPressed: (){}, icon:Icon(Icons.build), label: Text("小学生"))
      ],),),
    );
  }
}

class MychildList extends StatelessWidget {
  const MychildList({
    Key ?key,
    @required String ?imagrurl,
  }) : _imagrurl = imagrurl, super(key: key);

  final String ?_imagrurl;

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(_imagrurl!),),
    title: Text("昵称：花和尚鲁智深"),
    subtitle: Text("加入时间：${DateTime.now()}"),
    trailing: IconButton(icon: Icon(Icons.add_box),onPressed: (){},),),
    );
  }
}

class Mysliverheader extends SliverPersistentHeaderDelegate{
  var image;
  var headerData;
  Mysliverheader(image,headerData){
    this.image = image;
    this.headerData = headerData;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: headerData.teamCover.length,
          itemBuilder: (context,index){
        return Container(
          width: MediaQuery.of(context).size.width/1.5,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(headerData.teamCover[index]),fit: BoxFit.cover),color: Colors.blue,boxShadow: [BoxShadow(offset: Offset(10,20.0),color: Colors.black38,spreadRadius: 10.0,blurRadius: 10.0)]),
        );
      }),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 200.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

