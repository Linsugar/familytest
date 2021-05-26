
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String _imageUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F02%2F112809qybz22ltn8ybxt2x.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624344471&t=946bad365fde68214402444d79c26577';
  List imageList=[];
  TabController ?tabcontroller;
  List<wxinfo> wxList = [];
  int index =0;
  @override
  void initState() {
    tabcontroller  =TabController(length: 4, vsync: this)..addListener(() {
      print("得到的数据:${tabcontroller!.index}");
      if(tabcontroller!.animation!.value ==tabcontroller!.index){
        print("重复调用进行过滤");
      }else{
        setState(() {
          index = tabcontroller!.index;
          print("打印");
        });
      }
    });
    Roogyun.roogclient(context.read<GlobalState>().roogtoken);
    _GeWxContext();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  _GeWxContext()async{
    var wx = context.read<GlobalState>();
    if(wx.wxlist.isEmpty){
      dynamic result = await Request.getNetwork("wxarticle/");
      result.forEach((value){
        print("home:$value");
        wx.changewxlist(wxinfo(value));
      });
      await ShowAlerDialog(context);
      return wxList;
    }else{
      return wxList;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
            scrollDirection:Axis.vertical,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                title:homeInput(),
                expandedHeight: 120,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(_imageUrl,fit: BoxFit.cover,),
                ),
              ),
              SliverToBoxAdapter(child: HomePage()),
            ])
    );
  }
}

//首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String _imageUrl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F02%2F112809qybz22ltn8ybxt2x.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624344471&t=946bad365fde68214402444d79c26577';
  List imageList=[];
  @override
  void initState() {
    this.imageList = [_imageUrl,_imageUrl,_imageUrl,_imageUrl];
    Roogyun.roogclient(context.read<GlobalState>().roogtoken);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var wx = context.watch<GlobalState>().wxlist;
    return Column(
      children: [
        Container(
          height: _size.height/4,
          color: Colors.orange,child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CircleAvatar(backgroundImage: NetworkImage(context.watch<GlobalState>().avator!),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Hi,${context.watch<GlobalState>().username}",style: TextStyle(fontWeight: FontWeight.w800),),Text("Hi,欢迎加入健康大家庭")],),
                ],),
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.orange),
                      shadowColor:MaterialStateProperty.all(Colors.white)
                  ),
                    onPressed: (){}, icon: Icon(Icons.forward), label: Text("管理情况"))
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              height: _size.height/7,
              child: Row(
                children: [
                  Expanded(flex: 3,child: Container(decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/help.png'),fit: BoxFit.cover)),)),
                  Expanded(flex: 6,child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("快速了解【压一压】",style: TextStyle(fontWeight: FontWeight.w900),),
                    Text("养成良好行为习惯 控制疾病早日康复")
                  ],)),
                  Expanded(flex: 1,child:Icon(Icons.forward))
                ],
              ),
            ),
          ],
        ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Expanded(child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5)
            ),
            width: 150,height: 100,child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("病例档案",style: TextStyle(fontWeight: FontWeight.w900),),
                      Text("日常记录健康指标"),
                    ],
                  ),
                ),
                Expanded(flex: 3,child: Center(child: FaIcon(FontAwesomeIcons.commentDots)))
              ],
            ),)),
          Expanded(child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("找医生",style: TextStyle(fontWeight: FontWeight.w900),),
                      Text("国内三级医院优秀医生在线问诊"),
                    ],
                  ),
                ),
                Expanded(flex: 3,child: Center(child: FaIcon(FontAwesomeIcons.commentDots)))
              ],
            ),
            margin: EdgeInsets.all(5),
            width: 150,height: 100,decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5)
            ),)),
        ],),
        Container(
          height: 100,
          width: double.infinity,
          child: homeCarousel(imageList),
        ),
        StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics:NeverScrollableScrollPhysics() ,
          crossAxisCount: 4,
          itemCount: wx.length,
          itemBuilder: (BuildContext context, int index) => new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/webviewcpns',arguments: {
                    "wxcontext":wx[index]
                  });
                },
                child: Column(
                  children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(wx[index].wxphoto),fit: BoxFit.cover
                          )
                      ),)),
                    Text("${wx[index].wxtitle}",overflow: TextOverflow.ellipsis,)
                  ],
                ),
              )),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )
      ],
    );
  }
}

//首页搜索框
Widget homeInput(){
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white,width: 1.0)),
      padding: EdgeInsets.only(left: 10,right: 10),
      child:TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search),suffixIcon: Icon(Icons.arrow_drop_down),hintText: '请输入搜索内容'),)
  );
}
//待定
Widget homeList(var iamgrulr,var wxcls){
  List<wxinfo> wxlist = [];
  _GeWxContext(int wxcls)async{
    if(wxlist.isEmpty){
      dynamic result = await Request.getNetwork("wxarticle/",params: {
        "wxclass":wxcls
      });
      result.forEach((value){
        wxlist.add(wxinfo(value));
      });
      return wxlist;
    }else{
      return wxlist;
    }
  }
  return FutureBuilder(
    future: _GeWxContext(wxcls),
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
        }, itemCount: wxlist.length);
      }
    },
  );
}

//首页轮播组件
Widget homeCarousel(List imageList){
  return CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 2.0,
      viewportFraction: 1.0,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      autoPlay: true,
//        enlargeCenterPage: true
    ),
    items: imageList.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: (){
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

