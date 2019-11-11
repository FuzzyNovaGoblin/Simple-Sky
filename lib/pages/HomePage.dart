import 'package:flutter/material.dart';
import 'package:simple_sky/main.dart' as base;
import 'package:simple_sky/pages/NowView.dart';
import 'package:simple_sky/pages/WeekView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    base.loadJson(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    tabController = new TabController(length: 2, vsync: this);

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Simple Sky"),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[Tab(text: "Now"), Tab(text: "Week")],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: ()=>base.loadJson(()=>setState((){})),
          )
        ],
      ),
      body: (base.currentLocation == null)
          ? Container()
          : TabBarView(
              controller: tabController,
              children: <Widget>[NowView(), WeekView()],
            ),
    );
  }
}
