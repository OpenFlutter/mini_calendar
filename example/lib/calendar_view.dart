import 'package:flutter/material.dart';

import 'package:mini_calendar/mini_calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  DateDay currentDay = DateDay.now();
  DateDay currentMonth = DateDay.now();
  MiniCalender _calender;

  @override
  Widget build(BuildContext context) {
    if (_calender == null) {
      _calender = MiniCalender(
        currentDay: currentDay,
        minTime: DateDay.now().copyWith(month: 1),
        maxTime: DateDay.now().copyWith(month: 12),
        width: MediaQuery.of(context).size.width,
        marks: {DateDay.now(): 12, DateDay.now().add(Duration(days: 2)): 4},
        onDaySelected: (day, data) {
          currentDay = day.copyWith();

          setState(() {});
        },
        buildMark: (ctx, day, data) {
          return Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              "$data",
              style: TextStyle(fontSize: 14, color: Colors.deepOrange),
            ),
          );
        },
        onMonthChange: (month) {
          currentMonth = month;
          setState(() {});
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('显示日历'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            OutlineButton(
              onPressed: () {
                _calender.prev();
              },
              child: Text('上一月'),
            ),
            OutlineButton(
              onPressed: () {
                _calender.goToDay(DateDay.now());
              },
              child: Text('恢复'),
            ),
            OutlineButton(
              onPressed: () {
                _calender.next();
              },
              child: Text('下一月'),
            ),
          ]),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: _calender,
          ),
          Text("当前选择月份：${currentMonth.year}-${currentMonth.month}\n当前选中日期：$currentDay")
        ],
      ),
    );
  }
}
