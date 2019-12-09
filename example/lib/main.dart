import 'package:flutter/material.dart';
import 'dart:async';

import 'calendar_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'mini calendar',
      home: new HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mini calendar'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CalendarViewPage()),
              );
            },
            child: new Text('显示日历'),
          )
        ],
      ),
    );
  }

  void pushPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return page;
    }));
  }
}
