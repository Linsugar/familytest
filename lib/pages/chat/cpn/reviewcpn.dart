import 'package:familytest/network/requests.dart';
import 'package:familytest/pages/home/Home.dart';
import 'package:familytest/provider/homeState.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:familytest/provider/grobleState.dart';

class ReviewCpn extends StatefulWidget {
  Map ?arguments;
  ReviewCpn(this.arguments);
  @override
  _ReviewCpnState createState() => _ReviewCpnState();
}

class _ReviewCpnState extends State<ReviewCpn> {
  var data;
  TextEditingController _textEditingController = TextEditingController();
  ScrollController  _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    data = widget.arguments!['data'];
    _getreview(data.dyid);
    super.initState();
  }

  _getreview(int ?dyid)async{
    Provider.of<homeState>(context,listen: false).reviewlist.clear();
   var _result = await Request.getNetwork('review/',params: {'review_rd':dyid});
   _result.forEach((value){
     Provider.of<homeState>(context,listen: false).changereview(value);
   });
   return _result;
  }

  _postreview(int ?dyid)async{
   var _result = await Request.setNetwork('review/',{
     'review_rd':dyid,
     'recview_avator':context.read<GlobalState>().avator,
     'review_content':_textEditingController.text,
     'review_name':context.read<GlobalState>().username,
     'review_bool':1,
   },token: context.read<GlobalState>().logintoken);
   print("得到的结果:$_result");
   if(_result['msg'] == "成功" && _result['code']==200){
     PopupUntil.showToast(_result['msg']);
     _getreview(dyid);
   }else{
     PopupUntil.showToast(_result['msg']);
     return;
   }
  }


  @override
  Widget build(BuildContext context) {
  List  _imagelist = data.imagelist;
  List snda = context.watch<homeState>().reviewlist;
  print("数据是否有误：$snda");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("详情"),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(flex:5,child:Container(
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
                        minHeight: 30,
                      ),
                      child:  Text("${data.con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
                  ),
                  SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 50,
                      maxHeight: 100,
                    ),
                    child: Container(
                      height: 100,
                      child: _imagelist.isEmpty?Text("用户未上传图片"):ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,im){
                            return Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(_imagelist[im]),
                                      fit: BoxFit.cover
                                  )
                              ),
                              width: 80,
                            );
                          }, separatorBuilder: (context,im){
                        return SizedBox(width: 5,height: 5,);
                      }, itemCount:_imagelist.length),
                    ),
                  ),
                  Row(children: [SizedBox(width: 5,),Text("评论",textAlign:TextAlign.start,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),],),
                  Expanded(flex: 5,child:snda.isEmpty?Center(child: Text("暂无评论，快来做第一个吧")):ListView.separated(
                    controller: _scrollController,
                      itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(snda[index]['recview_avator']),),
                      title: Text("${snda[index]['review_name']}"),
                      subtitle: Text("${snda[index]['review_content']}"),
                    );
                  }, separatorBuilder: (context,index){
                    return Divider();
                  }, itemCount: snda.length)),
                  Row(
                    children: [
                      Expanded(flex: 7,child:  Container(
                        child: TextField(controller: _textEditingController,maxLines: 1,
                          decoration: InputDecoration(
                          hintText: "请输入评论内容",
                        ),),
                      )),
                      Expanded(flex: 3,child: MaterialButton(child: Text("发送"),onPressed: ()async{
                        await _postreview(data.dyid);
                        _textEditingController.clear();
                        PopupUntil.showToast("发布成功,请刷新页面");
                      },))
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      )
    );
  }
}
