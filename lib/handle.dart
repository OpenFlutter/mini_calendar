import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';

import 'model/date_day.dart';

TextStyle weekDayStyle = TextStyle(fontSize: 12, color: Colors.blue);
TextStyle disableDayStyle = TextStyle(fontSize: 12, color: Colors.grey[400]);
TextStyle weekendDayStyle = TextStyle(fontSize: 12, color: Colors.pink);

/// 默认构建星期标题
Widget defaultBuildWeekHead(BuildContext context, int week) {
  switch (week) {
    case 1:
      return Text('一', style: weekDayStyle.copyWith(color: Colors.black87));
    case 2:
      return Text('二', style: weekDayStyle.copyWith(color: Colors.black87));
    case 3:
      return Text('三', style: weekDayStyle.copyWith(color: Colors.black87));
    case 4:
      return Text('四', style: weekDayStyle.copyWith(color: Colors.black87));
    case 5:
      return Text('五', style: weekDayStyle.copyWith(color: Colors.black87));
    case 6:
      return Text('六', style: weekendDayStyle);
    case 0:
      return Text('日', style: weekendDayStyle);
  }
  return Container();
}

/// 默认构建月视图背景
Widget defaultBuildMonthBackground(BuildContext context, DateMonth month) {
  return Text("${month.month}", style: TextStyle(fontSize: 120, color: Colors.black12));
}

/// 构建Mark,[day]-日期，[data]-数据
typedef BuildMark<T> = Widget Function(BuildContext context, DateDay day, T data);

/// 构建月视图背景,[month]-月份
typedef BuildMonthBackground = Widget Function(BuildContext context, DateMonth month);

/// 构建星期头 [week] ：0-周日，1-周一，2-周二，3-周三，4-周四，5-周五，6-周六
typedef BuildWeekHead = Widget Function(BuildContext context, int week);

/// 当日期被选中时
typedef OnDaySelected<T> = void Function(DateDay day, T data);

/// 连选回调 [firstDay]-开始日期，[secondDay]-结束时间
typedef OnContinuousSelectListen = void Function(DateDay firstDay, DateDay secondDay);
