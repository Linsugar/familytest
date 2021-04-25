import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:provider/provider.dart';
import 'model.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}


class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';
  List imagelist=[];
  List a = [1,2,3,4];
  var tabcontlore;
  @override
  void initState() {
     tabcontlore  =TabController(length: 4, vsync: this);
     this.imagelist = [_imagrurl,_imagrurl,_imagrurl,_imagrurl];
     Roogyun.roogclient(context.read<GlobalState>().roogtoken);
     _getuserinfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  _getuserinfo()async{
    Provider.of<GlobalState>(context,listen: false).overuser!.clear();
    List<userinfomodel> userinfo= [];
    var result = await Request.getNetwork('userinfo/',params: {
      'user_id':context.read<GlobalState>().userid
    });
    result.forEach((value){
      Provider.of<GlobalState>(context,listen: false).changeoveruser(userinfomodel(value));
      userinfo.add(userinfomodel(value));
    });
    return userinfo;
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var userlist = context.watch<GlobalState>().overuser;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("首页"),),
      body: ListView(
          children: [
            Container(
              height: _size.height/10,
              child: ListView.separated(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,'/chatChild',arguments:{
                      "userinfo":userlist![index]
                    });
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2.0),shape:BoxShape.circle ,
                      boxShadow: [BoxShadow(color: Colors.blue,offset: Offset(0.0,1.0))],image: DecorationImage(image: NetworkImage(userlist![index].avator_image),fit: BoxFit.cover)
                  )),
                );
              },itemCount: userlist!.length,separatorBuilder: (context,index){
                return SizedBox(width: 10,);
              },)
            ),
            input(),
            photos(imagelist: imagelist),
            SizedBox(height: 10,),
            ctabr(tabcontlore: tabcontlore),
            ctab(tabcontlore: tabcontlore, imagrurl: _imagrurl),
            Text("最新消息~",textAlign: TextAlign.center,)
          ],
        ),

    );
  }
}

class ctab extends StatelessWidget {
  const ctab({
    Key? key,
    required this.tabcontlore,
    required String imagrurl,
  }) : _imagrurl = imagrurl, super(key: key);

  final  tabcontlore;
  final String _imagrurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: TabBarView(
        controller: tabcontlore,
        children: [
          Listcontext(_imagrurl,1),
          Listcontext(_imagrurl,2),
          Listcontext(_imagrurl,3),
          Listcontext(_imagrurl,4),
        ],
      ),
    );
  }
}

class ctabr extends StatelessWidget {
  const ctabr({
    Key? key,
    required this.tabcontlore,
  }) : super(key: key);

  final  tabcontlore;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabcontlore,
        tabs: [
          Text("汽车",style: TextStyle(fontSize: 15,color: Colors.black),),
          Text("搞笑",style: TextStyle(fontSize: 15,color: Colors.black),),
          Text("宠物",style: TextStyle(fontSize: 15,color: Colors.black),),
          Text("电竞",style: TextStyle(fontSize: 15,color: Colors.black),),
        ],
      ),
    );
  }
}

class photos extends StatelessWidget {
  const photos({
    Key? key,
    required this.imagelist,
  }) : super(key: key);

  final List imagelist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Text("今日热搜"),
          Text("全部"),
        ],),
        Container(
            child:cusor(imagelist:imagelist,)
        )
      ],
    );
  }
}

class input extends StatelessWidget {
  const input({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.lightBlue,width: 1.0)),
        padding: EdgeInsets.only(left: 10,right: 10),
        child:TextField(
          decoration: InputDecoration(icon: Icon(Icons.search),suffixIcon: Icon(Icons.arrow_drop_down),hintText: '请输入搜索内容'),)
    );
  }
}

class header extends StatelessWidget {
  const header({
    Key? key,
    required this.spdata,
  }) : super(key: key);

  final  spdata;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),child:
    ListView.separated(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context,'/chatChild',arguments:{
            "userinfo":spdata[index]
          });
        },
        child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2.0),shape:BoxShape.circle ,
            boxShadow: [BoxShadow(color: Colors.blue,offset: Offset(0.0,1.0))],image: DecorationImage(image: NetworkImage(spdata[index].avator_image),fit: BoxFit.cover)
        )),
      );
    },itemCount: spdata.length,separatorBuilder: (context,index){
      return SizedBox(width: 10,);
    },)
    );
  }
}

class Listcontext extends StatefulWidget {

  Listcontext(iamgrulr,wxcls){
    imageurl = iamgrulr;
    wxclass = wxcls;
  }
  var imageurl;
  var wxclass;
  @override
  _ListcontextState createState() => _ListcontextState();
}

class _ListcontextState extends State<Listcontext> {
  List<wxinfo> wxlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _GeWxContext(int wxcls)async{
    if(wxlist.isEmpty){
      dynamic result = await Request.getNetwork("wxarticle/",params: {
        "wxclass":widget.wxclass
      });
      result.forEach((value){
        this.wxlist.add(wxinfo(value));
      });
      return wxlist;
    }else{
      return wxlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _GeWxContext(widget.wxclass),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }if(snapshot.hasError){
            return Text("数据有误");
          }else{
            return ListView.separated(
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/webviewcpns',arguments: {
                        "wxcontext":snapshot.data[index]
                      });
                    },
                    child: Container(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                           width: 100,
                            child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image(image: NetworkImage(snapshot.data[index].wxphoto),fit: BoxFit.cover,),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" 标题：${snapshot.data[index].wxtitle}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                              Text(" 发布时间:${snapshot.data[index].wxtime}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (context,index){
              return Divider();
            }, itemCount: this.wxlist.length);
          }
        },
    );
  }
}











class cusor extends StatelessWidget {
  const cusor({
    Key? key,
    required this.imagelist,
  }) : super(key: key);

  final List imagelist;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true
      ),
      items: imagelist.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: (){
//                  print("点击：${i}");
                  Navigator.pushNamed(context, "/videoWidget");
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5,blurRadius: 0.9,)],
                        color: Colors.amber
                    ),
                    child: Image(image: NetworkImage(i),fit: BoxFit.cover,)
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}



//====================================================雪花========================================
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'dart:math';
//
//class CustomerSnow extends StatefulWidget{
//  @override
//  _CustomerSnowState createState() => _CustomerSnowState();
//}
//
//class _CustomerSnowState extends State<CustomerSnow> with SingleTickerProviderStateMixin{
//  AnimationController _controller;
//  List<sw> nelis = List.generate(50, (value){
//    return sw();
//  });
//  @override
//  void initState() {
//    _controller = AnimationController(vsync: this,duration: Duration(seconds:1))..repeat();
//    // TODO: implement initState
//
//    super.initState();
//  }
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(title: Text("雪花"),),
//      body: Container(
//        decoration: BoxDecoration(
//            gradient: LinearGradient(
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter,
//                colors: [Colors.blue,Colors.blue[200]!,Colors.white],
//                stops: [0.0,0.7,0.95]
//            )
//        ),
//        constraints: BoxConstraints.expand(),
//        child: AnimatedBuilder(
//          animation:_controller ,
//          builder: (_, __) {
//            this.nelis.forEach((element) {
//              element.fall();
//            });
//            return CustomPaint(
//              painter: Snow(nelis),
//            );
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class Snow extends CustomPainter{
//
//  List<sw> nelis;
//  Snow(this.nelis);
//  @override
//  void paint(Canvas canvas, Size size) {
//    canvas.drawCircle(Offset(size.width/2.0,size.height-240), 60.0, Paint()..color=Colors.white);
//    canvas.drawOval(Rect.fromCenter(center: Offset(size.width/2.0,size.height-60), width: 250, height: 300),Paint()..color=Colors.white);
//    canvas.drawCircle(Offset(size.width/2.0-40,size.height-260), 10, Paint());
//    canvas.drawCircle(Offset(size.width/2.0+40,size.height-260), 10, Paint());
//    canvas.drawOval(Rect.fromCenter(center: Offset(size.width/2.0,size.height-220), width: 50, height: Random().nextDouble()*10+4),Paint()..color=Colors.red);
//    this.nelis.forEach((value) {
//      canvas.drawCircle(Offset(value.x,value.y), value.r, Paint()..color=Colors.white);
//    });
//  }
//  @override
//  bool shouldRepaint(covariant CustomPainter oldDelegate) {
//    // TODO: implement shouldRepaint
//    return true;
//  }
//}
//
//class sw{
////  左右移动
//  double x = Random().nextDouble()*400.0;
//// 向下
//  double y = Random().nextDouble()*800.0;
////  半径
//  double r = Random().nextDouble()*7.0;
////  速度
//  double v = Random().nextDouble()*5;
//  fall(){
//    y+=v;
//    if(y>=800){
//      x = Random().nextDouble()*400.0;
//      y = Random().nextDouble()*800.0;
//      r = Random().nextDouble()*7.0;
//      v = Random().nextDouble()*5;
//    }
//  }
//}