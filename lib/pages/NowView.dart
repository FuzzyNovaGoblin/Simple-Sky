import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_sky/main.dart' as base;
import 'package:flutter_svg/flutter_svg.dart';

class NowView extends StatefulWidget {
  @override
  _NowViewState createState() => _NowViewState();
}

class _NowViewState extends State<NowView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          "assets/svg/" + base.bloc["currently"]["icon"] + ".svg",
          semanticsLabel: base.bloc["currently"]["icon"],
          fit: BoxFit.fitWidth,
          color: Colors.white,
        ),
        Text(base.bloc["currently"]["temperature"].toString() + "°"),
        Text(base.bloc["minutely"]["summary"]),
        Flexible(
            child: ListView(

          children: HourView.genHours(),
        ))
      ],
    );
  }
}

class HourView extends StatefulWidget {
  final String icon;
  final String summary;
  final DateTime time;
  final num temperature;

  HourView(Map<String, dynamic> hour)
      : time = DateTime.fromMillisecondsSinceEpoch(hour["time"] * 1000),
        icon = hour["icon"],
        summary = hour["summary"],
        temperature = hour["temperature"] {
    print(time);
  }

  static List<Widget> genHours() {
    List<Widget> foo = [];
    for (int i = 1; i < base.bloc["hourly"]["data"].length; i++) {
      foo.add(HourView(base.bloc["hourly"]["data"][i]));
    }
    return foo;
  }

  @override
  _HourViewState createState() => _HourViewState();
}

class _HourViewState extends State<HourView> {
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
                Flexible(flex: 3, child: Text("${TimeOfDay.fromDateTime(widget.time).format(context)}   ${widget.summary}")),
                Flexible(child: Text("${widget.temperature}°"))
              ],
            ),
          ),
        ));
  }
}
