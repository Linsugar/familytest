
import 'package:flutter/material.dart';

class Chat extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Chatstate();
  }
}

class Chatstate extends State<Chat>  with SingleTickerProviderStateMixin{
  AnimationController _Amc;
  String _headerimag = 'http://qr0n4nltx.hn-bkt.clouddn.com/p3.jpg';
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';
  @override
  void initState() {
    super.initState();
    _Amc = AnimationController(vsync: this,duration: Duration(seconds: 300));

  }
  @override
  void dispose() {
    _Amc.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("聊天3"), actions: [
          PopuWidget()
        ],),
        body: Container(padding: EdgeInsets.only(top: 10),width: _size.width,height: _size.height,child: ListView.separated(
          itemCount: 20,
          itemBuilder: (context,index){
            if(index == 0){
              return ListTile(
                key: UniqueKey(),
                subtitle: Text("在这里可以与许多不同的朋友一起畅聊生活琐事",overflow: TextOverflow.ellipsis,maxLines: 1,),
                leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(_headerimag),),title: Text("聊天广场"),trailing: MaterialButton(onPressed: (){
                print("点击$index");
                _Amc.forward();
                Navigator.pushNamed(context,'/chatChild');
              },child: Icon(Icons.pan_tool,color: Colors.cyan,)),);
            }
            return ListTile(
              key: UniqueKey(),
              subtitle: Text("一段凄美而无奈的感人肺腑的爱情",overflow: TextOverflow.ellipsis,maxLines: 1,),
              leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(_imagrurl),),title: Text("九尾妖狐"),trailing: MaterialButton(onPressed: (){
              print("点击$index");
              _Amc.forward();
              Navigator.pushNamed(context,'/chatChild');
            },child: Icon(Icons.tab)),);
          },separatorBuilder: (context,index){
          return Divider();
        },),)
    );
  }
}

class PopuWidget extends StatelessWidget {
  const PopuWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.all(8),
        offset: Offset(0,5.0),
        onSelected: (value){
          print("选中的值:$value");
        },
        itemBuilder:(BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: '选项一的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.account_circle,color: Colors.lightBlue,),Text("添加好友")],)
          ),
          PopupMenuItem<String>(
              value: '选项二的值',
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.search,color: Colors.lightBlue,),Text("搜索好友")],)

          )
        ]
    );
  }
}
