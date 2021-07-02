
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/until/CommonUntil.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'model/model.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  String _imageUrl = 'http://qtr6xp7uf.hn-bkt.clouddn.com/imge.png';
  TabController ?tabcontroller;
  List<wxinfo> wxList = [];
  int index =0;
  FocusNode _focusNode =FocusNode();
  TextEditingController? _textEditingController;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _focusNode.unfocus();
    _textEditingController = TextEditingController();
    _getWxContext();
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
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  _getWxContext()async{
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
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                title:homeInput(_textEditingController!,_focusNode),
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
  @override
  void initState() {
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
            Padding(padding: EdgeInsets.all(5),child: Row(
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
            ),),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
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
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(5)
            ),
            width: 150,height: 100,child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: archivesWgt(context),
                ),
                Expanded(flex: 3,child: Center(child: FaIcon(FontAwesomeIcons.commentDots)))
              ],
            ),)),
          Expanded(child: findDoctor(context)),
        ],),
        Container(
          height: 100,
          width: double.infinity,
          child: Column(children: [
            Expanded(flex: 15,child: homeCarousel(context)),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                for(var i=0;i<4;i++)
                  Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: i==context.watch<homeState>().carIndex?Colors.orange:Colors.blueGrey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    width: 10,height: 10,),
              ],),
            )
          ],),
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

//首页轮播组件
Widget homeCarousel(context){
  List listVideo = Provider.of<homeState>(context).videoList;
  return  CarouselSlider(
    options: CarouselOptions(
      onPageChanged: (int index, CarouselPageChangedReason reason){
        print("当前下标：$index");
        Provider.of<homeState>(context,listen: false).changindex(index);
      },
      aspectRatio: 3.7,
      viewportFraction: 1.0,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      autoPlay: true,
    ),
    items: listVideo.map((value) {
      return Builder(
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/videoWidget",arguments: {'value':value});
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5,blurRadius: 0.9,)],
                      color: Colors.amber
                  ),
                  child: Image(image: NetworkImage(value.videoCover),fit: BoxFit.cover,)
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

//病历档案
Widget archivesWgt(context){
  return InkWell(
    onTap: (){
      Navigator.of(context).pushNamed('/archives');
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("病例档案",style: TextStyle(fontWeight: FontWeight.w900),),
        Text("日常记录健康指标"),
      ],
    ),
  );
}

//找医生
Widget findDoctor(context){
  return InkWell(onTap: (){
    Navigator.pushNamed(context, '/doctor');
  },child: Container(
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
      color: Colors.orangeAccent,
      borderRadius: BorderRadius.circular(5)
  ),),);
}