import 'package:flutter/material.dart';
import 'package:simple_sky/main.dart' as base;
import 'package:flutter_svg/flutter_svg.dart';

class WeekView extends StatefulWidget {
  @override
  _WeekViewState createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: DayView.genDays(),
    );
  }
}

class DayView extends StatefulWidget {
  final String icon;
  final String summary;
  final DateTime time;
  final num tempHigh, tempLow;

  DayView(Map<String, dynamic> day)
      : time = DateTime.fromMillisecondsSinceEpoch(day["time"] * 1000),
        icon = day["icon"],
        summary = day["summary"],
        tempHigh = day["temperatureHigh"],
        tempLow = day["temperatureLow"];

  static List<Widget> genDays() {
    List<Widget> foo = [];
    for (int i = 1; i < base.bloc["daily"]["data"].length; i++) {
      foo.add(DayView(base.bloc["daily"]["data"][i]));
    }
    return foo;
  }

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  String getWeekAbr(int n) {
    switch (n) {
      case 7:
        return "Sun";
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Card(
          color: Colors.black,
          child: Container(
            height: 90,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/svg/${widget.icon}.svg",
                    fit: BoxFit.fitHeight,
                    width: 90,
                    color: Colors.white,
                  ),
                ),
                Flexible(child: Text(getWeekAbr(widget.time.weekday))),
                Flexible(flex: 2, child: Text("${widget.summary}")),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("${widget.tempHigh}°"),
                      Text("${widget.tempLow}°"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
