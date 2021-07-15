import 'package:dio/dio.dart';

class Request{
  static Dio network = new Dio(BaseOptions(
    connectTimeout: 5000,
//    baseUrl:'http://tlapp.club:8002/Jia/'
//    baseUrl: 'http://3ie5702133.wicp.vip/Jia/'
////    测试
//    baseUrl: 'http://192.168.1.5:8000/Jia/',
    baseUrl: 'http://192.168.5.208:8000/Jia/',
  ))..interceptors.add(InterceptorsWrapper(
    onRequest:(options, handler) {
      print("进入拦截onRequest${options.data}");
      print("header1:${options.headers}");
      return handler.next(options);
    },
    onResponse:(response,handler) {
//      print("进入拦截onResponse${response.data}");
      return handler.next(response); // continue
    },
  ));

  static getNetwork(url,{Map<String, dynamic> ?params,token})async{

    var options = Options(
      headers: {
        "Authorization":token==null?'':token
      }
    );
    try{
      var getResult = await network.get(url,queryParameters: params,options: options);
      return getResult.data;

    }catch(e){
      print("get：$e");
    }
  }

  static setNetwork(String url,data,{String ?token})async{
    var options = Options(
        headers: {
          "Authorization":token==null?'':token
        }
    );
    try{
      print('roogpost：===========================================');
      var postResult = await network.post(url,data: data,options: options);
      return postResult.data;
    }catch(e){
      print("post：$e");
    }
  }

}

