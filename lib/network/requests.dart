import 'package:dio/dio.dart';

class Request{
  static Dio network = new Dio(BaseOptions(
    connectTimeout: 3000,
    baseUrl: 'http://192.168.2.162:8000/Jia/'
  ));

  static getNetwork(url,{Map<String, dynamic> params})async{
    try{
      var getResult = await network.get(url,queryParameters: params);
      print("返回的数据：${getResult.data}");
      print("返回的数据：${getResult.data.runtimeType}");
      print("返回的数据：${getResult.data['user_mobile']}");
      return getResult.data;

    }catch(e){
      print("get：$e");
    }
  }
  static setNetwork(String url,Map<String, dynamic>params )async{
    try{
      var postResult = await network.post(url,data: params);
      return postResult.data;
    }catch(e){
      print("post：$e");
    }

  }
}