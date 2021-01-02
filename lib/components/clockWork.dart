import 'package:flutter/material.dart';

class ClockWork extends StatefulWidget {
  final minutes, seconds, milisecs;
  ClockWork(
      {Key key,
      @required this.minutes,
      @required this.seconds,
      @required this.milisecs})
      : super(key: key);
  @override
  _ClockWorkState createState() => _ClockWorkState();
}

class _ClockWorkState extends State<ClockWork> {
  @override
  Widget build(BuildContext context) {
    var minute, seconds, milisecs;
    if (widget.minutes < 10) {
      minute = '0${widget.minutes}';
    } else {
      minute = '${widget.minutes}';
    }

    if (widget.seconds < 10) {
      seconds = '0${widget.seconds}';
    } else {
      seconds = '${widget.seconds}';
    }

    if (widget.milisecs < 10) {
      milisecs = '0${widget.milisecs}';
    } else {
      milisecs = '${widget.milisecs}';
    }
    return Center(
      child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: MediaQuery.of(context).size.width / 4,
          child: Text(
            '$minute:$seconds:$milisecs',
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 40, color: Colors.white),
          )),
    );
  }
}
