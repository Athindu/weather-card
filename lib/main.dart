import 'package:flutter/material.dart';
import 'package:weather_data/home_page.dart';
import 'package:weather_data/onboard.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: HomeView(),
      ),
    );
  }
}