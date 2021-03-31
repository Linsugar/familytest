

import 'package:flutter/material.dart';
class feedbook extends StatefulWidget {
  @override
  _feedbookState createState() => _feedbookState();
}

class _feedbookState extends State<feedbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("反馈"),),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Container(decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey,width: 1.0)),child: TextField(maxLines: 10,)),
            MaterialButton(color: Colors.blueAccent[100],onPressed: (){},child: Text("反馈"),)
          ],
        ),
      ),
    );
  }
}
