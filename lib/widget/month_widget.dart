///
/// 月视图
///
///
import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_calendar/model/date_month.dart';
import '../model/date_day.dart';
import '../handle.dart';
import 'day_widget.dart';

class MonthWidget<T> extends StatelessWidget {
  /// 所在月份
  final DateMonth currentMonth;

  /// 当前选中日期
  final DateDay currentDay;

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

  /// 第一列是星期几（1，2，3，4，5，6，7）
  final int firstWeek;

  const MonthWidget({
    Key key,
    this.currentMonth,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.dayHeight,
    this.width = double.infinity,
    this.buildMark,
    this.marks = const {},
    this.onDaySelected,
    this.currentDay,
    this.firstWeek = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _dayWidth = (width - padding.left - padding.right - 18.0) / 7.0;
    double _dayHeight = dayHeight ?? _dayWidth;
    int startWeek = currentMonth.monthFirstDay.weekday;
    List<Widget> items = [];
    DateDay _time = DateDay.now();
    int headSize = 0;
    if (startWeek > firstWeek) {
      headSize = startWeek - firstWeek;
    } else if (startWeek < firstWeek) {
      headSize = 7 - firstWeek + startWeek;
    }
    List.generate(headSize, (index) {
      _time = DateDay(currentMonth.monthFirstDay.year,
              currentMonth.monthFirstDay.month, 1)
          .subtract(Duration(days: headSize - index));
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
    });

    List.generate(currentMonth.maxDays, (index) {
      _time = DateDay(currentMonth.monthFirstDay.year,
              currentMonth.monthFirstDay.month, 1)
          .add(Duration(days: index));
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

    int endSize = 42 - headSize - currentMonth.maxDays;
    for (int i = 1; i <= endSize; i++) {
      _time = DateDay(currentMonth.monthEndDay.year,
              currentMonth.monthEndDay.month, currentMonth.maxDays)
          .add(Duration(days: i));
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
      height: _dayHeight * 6 + padding.top + padding.bottom + 15,
      width: width,
      padding: padding,
      color: color,
      child: Wrap(spacing: 3, runSpacing: 3, children: items),
    );
  }
}
