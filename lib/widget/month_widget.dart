///
/// 月视图
///
///
import 'package:flutter/material.dart';
import '../handle.dart';
import 'day_widget.dart';

class MonthWidget extends StatelessWidget {
  /// 当前选择的日期
  final DateTime pickingDay;

  ///
  final EdgeInsets padding;

  final Color color;

  final double width;
  final double dayHeight;

  const MonthWidget({
    Key key,
    this.pickingDay,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.dayHeight,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _dayWidth = (width - padding.left - padding.right - 18.0) / 7.0;
    double _dayHeight = dayHeight ?? _dayWidth;
    DateHandle dateHandle = DateHandle(pickingDay);
    int startWeek = dateHandle.startDay.weekday;
    List<Widget> items = [];
    for (int i = 1; i < startWeek; i++) {
      items.add(DayWidget(
        dayTime:
            DateTime(dateHandle.startDay.year, dateHandle.startDay.month, 1)
                .subtract(Duration(days: startWeek - i)),
        style: disableDayStyle,
        height: _dayHeight,
        width: _dayWidth,
        edit: false,
      ));
    }
    List.generate(dateHandle.maxDays, (index) {
      items.add(DayWidget(
        dayTime:
            DateTime(dateHandle.startDay.year, dateHandle.startDay.month, 1)
                .add(Duration(days: index)),
        style: defaultDayStyle,
        height: _dayHeight,
        width: _dayWidth,
      ));
    });
    int endWeek = dateHandle.endDay.weekday;
    for (int i = 1; i < 8 - endWeek; i++) {
      items.add(DayWidget(
        dayTime: DateTime(dateHandle.endDay.year, dateHandle.endDay.month,
                dateHandle.endDay.day)
            .add(Duration(days: i)),
        style: disableDayStyle,
        edit: false,
        height: _dayHeight,
        width: _dayWidth,
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
