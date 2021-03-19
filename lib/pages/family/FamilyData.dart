
import 'package:familytest/routes/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Family extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FamilyState();
  }
}

class FamilyState extends State<Family>{
  String _imagrurl = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F17%2F20190117092809_ffwKZ.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616828490&t=47c56d1e82192312b85a0075b591034e';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("家族数据"),actions: [MaterialButton(onPressed: (){},child: Icon(Icons.account_circle,color: Colors.lightBlueAccent,),)],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(flex: 3,child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 2,child:Container(margin: EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
                    IconButton(icon: Icon(Icons.add_circle), onPressed: (){}),
                  ],),
                )),
              Flexible(flex: 15,child: Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: ListView.separated(scrollDirection: Axis.horizontal,itemCount: 20,separatorBuilder: (context,index){
                  return SizedBox(width: 10,);
                },itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Application.router.navigateTo(context, '/childfamily');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/idcard.png'),fit: BoxFit.contain
                          )
                        ),width: 230),
                      ),
                    );
                },),
              ),)
              ],
            ),),
            Flexible(flex: 7,child: Container(
              margin: EdgeInsets.only(left: 30,right: 30,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(-1.0,2.0),spreadRadius: 2.0)],
                  borderRadius: BorderRadius.circular(10),),
                child: ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Container(child:Flex(direction: Axis.vertical,children: [
                      Flexible(flex: 2,child: Container(
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(0.0,3.0),color: Colors.deepPurpleAccent[100],blurRadius: 10.0)]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(decoration: BoxDecoration(color: Colors.deepPurpleAccent[100]),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.access_alarm),Text("闹钟"),],),
                          ],),),
                        ),
                      )),
                      Flexible(flex: 1,child: Container(padding: EdgeInsets.all(10),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Text("展示热点"),
                        Text("全部"),
                      ],),),),
                      Flexible(flex: 7,child:ListView.builder(itemCount: 20,itemBuilder: (context,index){
                        return ListTile(
                          onTap: (){
                            Application.router.navigateTo(context, '/childfamily');
                          },
                          leading: CircleAvatar(backgroundImage: NetworkImage(_imagrurl),),
                        title: Text("唐氏家族"),
                        subtitle: Text("创建于2020-12-12，现任族长唐林",maxLines: 1,overflow: TextOverflow.ellipsis,),
                        trailing: Text("￥230.000"),);
                      })),
                    ],)))),),
          ],
        ),
      ),
    );
  }
}