// *************************************************
// Flutter Clock Challenge submission by Kevin Ryan
// November 2019
// Contact: kevin.ryan7@gmail.com
// *************************************************

// standard imports
import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// custom clock font widgets
import 'digit.dart';
import 'colon.dart';

// light theme provides weather conditions
final _lightTheme = {
'cloudy':Colors.blueGrey,
'foggy':Colors.blueGrey,
'rainy':Colors.blue,
'snowy':Colors.white,
'sunny':Colors.black,
'thunderstorm':Colors.blue,
'windy':Colors.black,
};

// dark theme ignores weather (blackout)
final _darkTheme = {
'cloudy':Colors.black,
'foggy':Colors.black,
'rainy':Colors.black,
'snowy':Colors.black,
'sunny':Colors.black,
'thunderstorm':Colors.black,
'windy':Colors.black,
};

/// A nixie tube themed digital clock.
/// Glow corresponds to weather conditions
class NixieClock extends StatefulWidget {
  const NixieClock(this.model);
  final ClockModel model;
  
  @override
  _NixieClockState createState() => _NixieClockState();
}

class _NixieClockState extends State<NixieClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(NixieClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final _weatherColor = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    
    return Container(
      // color gradient to visualize weather
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops:[0.0,0.1],
              // future proof if weather conditions are not in _weatherColor
              colors:[_weatherColor[widget.model.weatherString]==null ?
              Colors.black:_weatherColor[widget.model.weatherString]
              ,Colors.black])),

       // Stack digit images (XX:XX format) using Digits and Colon Widgets
       // - ten's digit string logic- off or 0 if less than 10
       // - one's digit math, mod
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Digit(int.parse(hour)>=10 ? int.parse(hour[0]) : -1,-1.0),
          Digit(int.parse(hour)%10,-0.333333),
          Colon(),
          Digit(int.parse(minute)>=10 ? int.parse(minute[0]) : 0,0.3333333),
          Digit(int.parse(minute)%10,1.0)
        ],
      ),
    );
  }
}
