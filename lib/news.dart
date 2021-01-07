import 'package:flutter/cupertino.dart';

class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("news", style: TextStyle(fontSize: 30),),
    );
  }
}
