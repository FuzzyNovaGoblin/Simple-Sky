import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/HomePage.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

Color darkGrey = Color(0xFF495057);

LocationData currentLocation;
Location location;
Map<String, dynamic> bloc;

Future getLocation() async {
  currentLocation = await location.getLocation();
}

Future loadJson(VoidCallback ss) async {
  await getLocation();
  String uri = "https://api.darksky.net/forecast/";
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  bloc = jsonDecode(await http.read("${uri}7400e86b6a41707396f99b2c2b9bc6c0/${currentLocation.latitude},${currentLocation.longitude}"));
  print("**********");
  print("${uri}7400e86b6a41707396f99b2c2b9bc6c0/${currentLocation.latitude},${currentLocation.longitude}");
  print("**********");
  ss();
}

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  location = new Location();

  runApp(MaterialApp(
    title: "Simple Sky",
    home: HomePage(),
    theme: ThemeData(
      textTheme: TextTheme(body1: TextStyle(color: Colors.white)),
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      canvasColor: Colors.black,
      splashColor: Colors.black,
      accentColor: Colors.grey,
    ),
  ));
}
