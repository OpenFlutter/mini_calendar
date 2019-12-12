import 'package:flutter/material.dart';
import 'package:mini_calendar/model/date_day.dart';
import 'package:mini_calendar/model/date_month.dart';

import '../mini_calendar.dart';

class MonthPage<T> extends StatefulWidget {
  /// 可用最小日期
  final DateDay enableMinDay;

  /// 可用最大日期
  final DateDay enableMaxDay;

  /// 初始化选中的日期
  final DateDay initDay;

  /// 初始化选中的月份
  final DateDay initMonth;

  /// 显示星期表头
  final bool showWeekHeader;

  /// 月份滑动改变
  final ValueChanged<DateMonth> onMonthChange;

  /// 日期选中
  final OnDaySelected<T> onDayPick;

  /// 标记集合
  final Map<DateDay, T> marks;

  /// 自定义构建标记
  final BuildMark<T> buildMark;

  const MonthPage(
      {Key key,
      this.enableMinDay,
      this.enableMaxDay,
      this.initDay,
      this.initMonth,
      this.showWeekHeader,
      this.onMonthChange,
      this.onDayPick,
      this.marks,
      this.buildMark})
      : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
