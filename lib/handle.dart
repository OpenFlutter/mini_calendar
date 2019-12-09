import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateHandle {
  DateTime time;
  int maxDays;
  DateTime startDay;
  DateTime endDay;

  DateHandle(this.time) {
    maxDays =
        DateTime(time.year, time.month + 1, 1).add(Duration(days: -1)).day;
    startDay = DateTime(time.year, time.month, 1);
    endDay = DateTime(time.year, time.month, maxDays);
  }

  @override
  String toString() {
    return 'DateHandle{time: $time, maxDays: $maxDays, startDay: $startDay, endDay: $endDay}';
  }
}

TextStyle defaultDayStyle = TextStyle(fontSize: 12, color: Colors.blue);
TextStyle disableDayStyle = TextStyle(fontSize: 12, color: Colors.grey);
TextStyle weekDayStyle = TextStyle(fontSize: 12, color: Colors.pink);

/// 是否是今天
bool isToDay(DateTime date) {
  DateTime nowTime = DateTime.now();
  return date.year == nowTime.year &&
      date.month == nowTime.month &&
      date.day == nowTime.day;
}
