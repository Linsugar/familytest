import 'package:shared_preferences/shared_preferences.dart';

class Shared{

  static setData(key,value)async{
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }



}