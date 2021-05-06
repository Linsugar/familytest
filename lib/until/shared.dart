import 'package:shared_preferences/shared_preferences.dart';

class Shared{


 static  getdata(String data)async{
   var result =await SharedPreferences.getInstance();
   print("开始进行获取");
   return result.getString(data);
  }

 static  setdata(String KeyName,String value)async{
   var result =await SharedPreferences.getInstance();
   print("开始进行设置");
   return result.setString(KeyName, value);
 }
}