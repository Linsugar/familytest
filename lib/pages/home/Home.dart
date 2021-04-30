import 'dart:convert';
import 'package:familytest/network/requests.dart';
import 'package:familytest/provider/grobleState.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:familytest/roog/roogYun.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  double hei = 200;
  var tabcontlore;
  List<wxinfo> wxlist = [];
  @override
  void initState() {
    tabcontlore  =TabController(length: 4, vsync: this);
    this.imagelist = [_imagrurl,_imagrurl,_imagrurl,_imagrurl];
    Roogyun.roogclient(context.read<GlobalState>().roogtoken);
    _GeWxContext();
    _Getimage();
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

  _GeWxContext()async{
    var wx = context.read<GlobalState>();
    if(wx.wxlist.isEmpty){
      dynamic result = await Request.getNetwork("wxarticle/");
      result.forEach((value){
        wx.changewxlist(wxinfo(value));
      });
      return wxlist;
    }else{
      return wxlist;
    }
  }

  _Getimage()async{
    var im = await rootBundle.loadString('data/home.json');
    print("数据返回：${im}");
    var imagedeoce  = json.decode(im);
    print("数据返回：${imagedeoce.length}");
    imagedeoce.forEach((value){
      Provider.of<homeState>(context,listen: false).changelist(value);
    });

  }
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var userlist = context.watch<GlobalState>().overuser;
    var wx = context.watch<GlobalState>().wxlist;
    var homelist = context.watch<homeState>().homelist;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection:Axis.vertical,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue[400],
            title: input(),
            bottom: TabBar(
              indicatorColor: Colors.white,
              controller: tabcontlore,
              labelPadding: EdgeInsets.only(bottom: 15),
              tabs: [
                Text("首页"),
                Text("周边游"),
                Text("亲子时光"),
                Text("踏青赏花"),
              ],),

          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: hei,
              child: PageView(
                onPageChanged: (value){
                  print("当前翻页;$value");
                  setState(() {
                    if(hei==200){
                      hei =360;
                    }else{
                      hei = 200;
                    }
                  });
                },
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                    (context,index){
                                  return InkWell(
                                    onTap: (){
                                      PopupUntil.showToast("功能暂未开放");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white,width: 1)
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(homelist[index]['url']),
                                                    fit: BoxFit.cover
                                                  )
                                                ),
                                          )),
                                          Expanded(flex: 1,child: Text("${homelist[index]['title']}",overflow:TextOverflow.ellipsis ,))
                                        ],
                                      ),
                                    ),
                                  );
                                },childCount: 15
                            ), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(

                            mainAxisExtent: 67,
                            crossAxisCount: 5))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                    (context,index){
                                  return InkWell(
                                    onTap: (){
                                      PopupUntil.showToast("功能暂未开放");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white,width: 1)
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(flex: 2,
                                              child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(homelist[index]['url']),
                                                fit: BoxFit.cover
                                              )
                                            ),
                                          )),
                                          Expanded(
                                            flex: 1,
                                              child: Text("${homelist[index]['title']}",overflow:TextOverflow.ellipsis))
                                        ],
                                      ),
                                    ),
                                  );
                                },childCount: 26
                            ), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 60,
                            crossAxisCount: 5))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10,),),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  width: _size.width/2,
                  child:cusor(imagelist: imagelist,) ,
                ),
                Container(
                  width: _size.width/2,
                  child:cusor(imagelist: imagelist,) ,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10,),),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: cusor(imagelist:imagelist,),
            ),
          ),
          SliverToBoxAdapter(
              child: StaggeredGridView.countBuilder(
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
              )),
        ],
      ),

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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white,width: 1.0)),
        padding: EdgeInsets.only(left: 10,right: 10),
        child:TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.search),suffixIcon: Icon(Icons.arrow_drop_down),hintText: '请输入搜索内容'),)
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
        viewportFraction: 1.0,
        autoPlay: true,
//        enlargeCenterPage: true
      ),
      items: imagelist.map((i) {
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
}

