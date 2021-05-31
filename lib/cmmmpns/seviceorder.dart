//服务订单

import 'package:flutter/material.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {


 Future orderData()async{
 var or = await Future.delayed(Duration(seconds: 2));
 return or;
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("服务订单",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),),
      body: FutureBuilder(
        future: orderData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.cover,
                  image: AssetImage('images/order.png')
                )
              ),
            );
          }
        },
      ),
    );
  }
}
