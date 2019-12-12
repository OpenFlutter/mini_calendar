import 'package:flutter/material.dart';
import 'dart:async';

import 'calendar_view.dart';
import 'page_view_page.dart';

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
          _buildItem(context, '显示日历', CalendarViewPage()),
          _buildItem(context, '测试切屏', PageViewPage()),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title ?? ''),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => page)),
    );
  }
}
