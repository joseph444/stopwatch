import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/clockWork.dart';
import 'package:stopwatch/screens/lapScreen.dart';

class clockScreen extends StatefulWidget {
  @override
  _clockScreenState createState() => _clockScreenState();
}

class _clockScreenState extends State<clockScreen> {
  var minutes = 0, seconds = 0, miliseconds = 0;
  //flag variable which will be used as init and end the timer
  var startTimer = false;
  var _pauseTimer = false;

  var _timer = const Duration(milliseconds: 10);

  final _laps = <String>[];

  //this function will change the values
  void callTimer(Timer t) {
    setState(() {
      //sleep(Duration(milliseconds: 10));
      if (startTimer && !_pauseTimer) {
        miliseconds++;
        if (miliseconds >= 99) {
          miliseconds = 0;
          seconds++;
        }
        if (seconds >= 59) {
          miliseconds = 0;
          seconds = 0;
          minutes++;
        }
        if (minutes > 59) {
          minutes = 0;
          seconds = 0;
          miliseconds = 0;
          startTimer = false;
        }
      }
    });
  }

  void timer() {
    new Timer.periodic(_timer, callTimer);
    setState(() {
      startTimer = true;
    });
  }

  void PauseTimer() {
    setState(() {
      _pauseTimer = !_pauseTimer;
    });
  }

  void ResetTimer() {
    setState(() {
      if (_pauseTimer) {
        minutes = 0;
        seconds = 0;
        miliseconds = 0;
        startTimer = false;
        _pauseTimer = false;
        _laps.clear();
      }
    });
  }

  void _AddLaps() {
    setState(() {
      if (startTimer) {
        final _mins = minutes < 10 ? '0$minutes' : '$minutes';
        final _secs = seconds < 10 ? '0$seconds' : '$seconds';
        final _msecs = miliseconds < 10 ? '0$miliseconds' : '$miliseconds';
        final lapTime = '$_mins:$_secs:$_msecs';
        _laps.add(lapTime);
      }
    });
  }

  void gotoLapsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _laps.map((String time) {
        return ListTile(
          title: Text(time),
        );
      });

      final List<Widget> _driver =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return LapScreen(lapList: _driver);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _laps.isNotEmpty
            ? [
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed: gotoLapsPage,
                )
              ]
            : [],
        centerTitle: true,
        title: Text(
          "StopWatch",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: ClockWork(
                minutes: minutes, seconds: seconds, milisecs: miliseconds),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !startTimer
                  ? RaisedButton(onPressed: timer, child: Text("Start"))
                  : RaisedButton(
                      onPressed: PauseTimer,
                      child: Text(!_pauseTimer ? "Pause" : "Resume")),
              RaisedButton(
                  color: Colors.red,
                  onPressed: _pauseTimer ? ResetTimer : _AddLaps,
                  child: Text(_pauseTimer ? "Reset" : "Laps"))
            ],
          ),
        ],
      ),
    );
  }
}
