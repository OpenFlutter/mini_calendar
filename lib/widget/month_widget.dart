///
/// 月视图
///
///
import 'package:flutter/material.dart';
import 'package:flutter_calendar/handle.dart';
import 'package:flutter_calendar/widget/day_widget.dart';

class MonthWidget extends StatelessWidget {
  /// 当前选择的日期
  final DateTime pickingDay;

  ///
  final EdgeInsets padding;

  final Color color;

  final double width;
  final double height;

  const MonthWidget({
    Key key,
    this.pickingDay,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.transparent,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = width - padding.left - padding.right;
    double _height = height - padding.top - padding.bottom;
    DateHandle dateHandle = DateHandle(pickingDay);
    int startWeek = dateHandle.startDay.weekday;
    print(startWeek);
    List<Widget> items = [];
    for (int i = 1; i < startWeek; i++) {
      items.add(DayWidget(
        dayTime:
            DateTime(dateHandle.startDay.year, dateHandle.startDay.month, 1).subtract(Duration(days: startWeek - i)),
        style: disableDayStyle,
      ));
    }
    List.generate(dateHandle.maxDays, (index) {
      items.add(DayWidget(
        dayTime: DateTime(dateHandle.startDay.year, dateHandle.startDay.month, 1).add(Duration(days: index)),
        style: defaultDayStyle,
      ));
    });
    int endWeek = dateHandle.endDay.weekday;
    for (int i = 1; i < 8 - endWeek; i++) {
      items.add(DayWidget(
        dayTime:
            DateTime(dateHandle.endDay.year, dateHandle.endDay.month, dateHandle.endDay.day).add(Duration(days: i)),
        style: disableDayStyle,
      ));
    }

    return Container(
      height: _height,
      width: _width,
      padding: padding,
      color: color,
      child: GridView.count(crossAxisCount: 7, padding: EdgeInsets.zero, children: items),
    );
  }
}
