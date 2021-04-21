import 'package:shared_preferences/shared_preferences.dart';

class Shared{


 Future getdata(String data)async{
   var result =await SharedPreferences.getInstance();
   return result.getString(data);
  }

 Future setdata(String token)async{
   var result =await SharedPreferences.getInstance();
   return result.setString('roongtoken', token);
 }
}