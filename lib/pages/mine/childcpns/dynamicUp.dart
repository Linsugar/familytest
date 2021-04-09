import 'package:flutter/material.dart';
class updynamic extends StatefulWidget {
  @override
  _updynamicState createState() => _updynamicState();
}

class _updynamicState extends State<updynamic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("发布动态"),),
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Expanded(flex: 4,child: TextField(maxLines: 15,)),
            Expanded(flex: 6,child: Container(color: Colors.blueGrey,)),
          ],
        ),
      ),
    );
  }
}
