import 'package:familytest/network/requests.dart';
import 'package:familytest/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:familytest/provider/grobleState.dart';

class reviewCpn extends StatefulWidget {
  Map ?arguments;
  reviewCpn(this.arguments);
  @override
  _reviewCpnState createState() => _reviewCpnState();
}

class _reviewCpnState extends State<reviewCpn> {
  var data;
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    data = widget.arguments!['data'];
    super.initState();
  }

  _getreview(int ?dyid)async{
   var _result = await Request.getNetwork('review/',params: {'review_rd':dyid});
   print("得到的结果数据：$_result");
   return _result;
  }

  _postreview(int ?dyid)async{
   var _result = await Request.setNetwork('review/',{
     'review_rd':dyid,
     'recview_avator':context.read<GlobalState>().avator,
     'review_content':_textEditingController.text,
     'review_name':context.read<GlobalState>().username,
     'review_bool':1,
   });
   print("发布评论结果：$_result");
   return _result;
  }


  @override
  Widget build(BuildContext context) {
  List  _imagelist = data.imagelist;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("详情"),),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(flex: 3,child:Container(
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
                          minHeight: 10,
                        ),
                        child:  Text("${data.con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
                    ),
                    SizedBox(height: 10),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 50,
                        maxHeight: 100,
                      ),
                      child:Column(
                        children: [
                          Expanded(flex: 3,
                            child:_imagelist.isEmpty?Text("用户未上传图片"):ListView.separated(
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
                        ],
                      ) ,
                    )
                  ],
                ),
              )),
              Expanded(child:Row(children: [SizedBox(width: 5,),Text("评论",textAlign:TextAlign.start,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),],),),
              Expanded(flex: 4,child: FutureBuilder(
                future: _getreview(data.dyid),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }if(snapshot.hasData){
                    List snda = snapshot.data;
                    if(snda.isEmpty){
                      return Center(child: Text("当前暂无评论"),);
                    }else{
                      return ListView.separated(itemBuilder: (context,index){
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(snda[index]['recview_avator']),),
                          title: Text("${snda[index]['review_name']}"),
                          subtitle: Text("${snda[index]['review_content']}"),
                        );
                      }, separatorBuilder: (context,index){
                        return Divider();
                      }, itemCount: snda.length);
                    }
                  }
                  else{
                    return Text("数据有误");
                  }
                },
              )),
              Expanded(child:Flex(direction: Axis.horizontal,children: [
                Expanded(flex: 7,child:  Container(
                  child: TextField(controller: _textEditingController,),
                )),
                Expanded(flex: 3,child: MaterialButton(child: Text("发送"),onPressed: ()async{
                 await _postreview(data.dyid);
                 _textEditingController.clear();
                 PopupUntil.showToast("发布成功,请刷新页面");
                 setState(() {

                 });
                },))
              ],),),
            ],
          ),
        ),
      ),
    );
  }
}



