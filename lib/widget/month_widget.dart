///
/// 月视图
///
///
import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import '../model/date_day.dart';
import '../handle.dart';
import 'day_widget.dart';

class MonthWidget<T> extends StatelessWidget {
  /// 所在月份
  final DateDay inMonth;

  /// 边距
  final EdgeInsets padding;

  /// 面板颜色
  final Color color;

  /// 面板宽度
  final double width;

  /// 日组件高度
  final double dayHeight;

  /// 自定义mark
  final BuildMark<T> buildMark;

  /// 点击事件
  final OnDaySelected<T> onDaySelected;

  /// 标记
  final Map<DateDay, T> marks;

  /// 当前选中日期
  final DateDay currentDay;

  const MonthWidget({
    Key key,
    this.inMonth,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.dayHeight,
    this.width = double.infinity,
    this.buildMark,
    this.marks = const {},
    this.onDaySelected,
    this.currentDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _dayWidth = (width - padding.left - padding.right - 18.0) / 7.0;
    double _dayHeight = dayHeight ?? _dayWidth;
    int startWeek = inMonth.monthFirstDay.weekday;
    List<Widget> items = [];
    DateDay _time = DateDay.now();
    for (int i = 1; i < startWeek; i++) {
      _time =
          DateDay(inMonth.monthFirstDay.year, inMonth.monthFirstDay.month, 1).subtract(Duration(days: startWeek - i));
      items.add(DayWidget(
        dayTime: _time,
        style: disableDayStyle,
        height: _dayHeight,
        width: _dayWidth,
        hasMark: marks.containsKey(_time),
        data: marks[_time],
        buildMark: buildMark,
        onDaySelected: onDaySelected,
        currentDay: currentDay,
        edit: false,
      ));
    }
    List.generate(inMonth.maxDays, (index) {
      _time = DateDay(inMonth.monthFirstDay.year, inMonth.monthFirstDay.month, 1).add(Duration(days: index));
      items.add(DayWidget(
        dayTime: _time,
        style: defaultDayStyle,
        height: _dayHeight,
        width: _dayWidth,
        hasMark: marks.containsKey(_time),
        data: marks[_time],
        buildMark: buildMark,
        onDaySelected: onDaySelected,
        currentDay: currentDay,
      ));
    });
    int endWeek = inMonth.monthEndDay.weekday;
    for (int i = 1; i < 8 - endWeek; i++) {
      _time = DateDay(inMonth.monthEndDay.year, inMonth.monthEndDay.month, inMonth.maxDays).add(Duration(days: i));
      items.add(DayWidget(
        dayTime: _time,
        style: disableDayStyle,
        edit: false,
        height: _dayHeight,
        width: _dayWidth,
        hasMark: marks.containsKey(_time),
        data: marks[_time],
        buildMark: buildMark,
        onDaySelected: onDaySelected,
        currentDay: currentDay,
      ));
    }

    return Container(
      height: _dayHeight * 7 + padding.top + padding.bottom,
      width: width,
      padding: padding,
      color: color,
      child: Wrap(spacing: 3, runSpacing: 3, children: items),
    );
  }
}
