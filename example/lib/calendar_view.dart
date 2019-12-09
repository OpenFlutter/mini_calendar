import 'package:flutter/material.dart';

import 'package:mini_calendar/mini_calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('显示日历'),
        centerTitle: true,
      ),
      body: MiniCalender(
        pickingTime: DateTime.now(),
        width: MediaQuery.of(context).size.width,
        onMonthChange: (month) {
          print("${month.year}-${month.month}");
        },
      ),
    );
  }
}
