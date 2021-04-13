import 'package:dio/dio.dart';

class Request{
  static Dio network = new Dio(BaseOptions(
    connectTimeout: 10000,
    baseUrl: 'http://192.168.5.208:8000/Jia/'
  ));

  static getNetwork(url,{Map<String, dynamic> ?params})async{
    try{
      var getResult = await network.get(url,queryParameters: params);
      print("返回的数据：${getResult.data}");
      return getResult.data;

    }catch(e){
      print("get：$e");
    }
  }
  static setNetwork(String url,data )async{
    try{
      print('post：$data');
      var postResult = await network.post(url,data: data);
      return postResult.data;
    }catch(e){
      print("post：$e");
    }

  }
}