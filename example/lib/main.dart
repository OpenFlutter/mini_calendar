import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_calendar/flutter_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('日历示例')),
        backgroundColor: Colors.grey,
        body: ListView(
          children: <Widget>[
            Container(
              height: 320,
              color: Colors.white,
              child: FlutterCalender(pickingTime: DateTime.now()),
            )
          ],
        ),
      ),
    );
  }
}
