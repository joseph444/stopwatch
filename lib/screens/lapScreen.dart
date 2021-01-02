import 'package:flutter/material.dart';

class LapScreen extends StatefulWidget {
  final lapList;
  LapScreen({Key key, @required this.lapList}) : super(key: key);
  @override
  _LapScreenState createState() => _LapScreenState();
}

class _LapScreenState extends State<LapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "StopWatch",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: ListView(
        children: widget.lapList,
      ),
    );
  }
}
