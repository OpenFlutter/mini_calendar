import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:mini_calendar/handle.dart';

import 'month_widget.dart';

///
class MiniCalender extends StatefulWidget {
  /// 当前选择的日期
  final DateTime pickingTime;

  /// 最小日期
  final DateTime minTime;

  /// 最大日期
  final DateTime maxTime;

  /// 日控件高度
  final double dayHeight;

  /// 日历宽度
  final double width;

  /// 月份滑动改变
  final ValueChanged<DateTime> onMonthChange;

  /// 显示星期
  final bool showWeekHeader;

  const MiniCalender({
    Key key,
    this.pickingTime,
    this.minTime,
    this.maxTime,
    this.onMonthChange,
    this.dayHeight,
    this.width = double.infinity,
    this.showWeekHeader = true,
  }) : super(key: key);

  @override
  _MiniCalenderState createState() => _MiniCalenderState();
}

class _MiniCalenderState extends State<MiniCalender> {
  List<MonthWidget> items = [];
  PageController _controller;
  int leftPosition = 1;
  int rightPosition = 1;

  @override
  void initState() {
    DateTime startTime = widget.minTime ??
        DateTime(widget.pickingTime.year, widget.pickingTime.month - 6, 1);
    DateTime endTime = widget.maxTime ??
        DateTime(widget.pickingTime.year, widget.pickingTime.month + 6, 1);
    if (startTime.isAfter(widget.pickingTime)) {
      startTime = DateTime.parse(widget.pickingTime.toIso8601String());
    }
    if (endTime.isBefore(widget.pickingTime)) {
      endTime = DateTime.parse(widget.pickingTime.toIso8601String());
    }
    leftPosition = (widget.pickingTime.year - startTime.year) * 12 +
        widget.pickingTime.month -
        startTime.month;
    rightPosition = (endTime.year - widget.pickingTime.year) * 12 +
        endTime.month -
        startTime.month;

    List.generate(leftPosition, (index) {
      items.add(MonthWidget(
        pickingDay: DateTime(widget.pickingTime.year,
            widget.pickingTime.month - leftPosition + index, 1),
        dayHeight: widget.dayHeight,
        width: widget.width,
      ));
    });
    items.add(MonthWidget(
      pickingDay: widget.pickingTime,
      dayHeight: widget.dayHeight,
      width: widget.width,
    ));
    List.generate(rightPosition, (index) {
      items.add(MonthWidget(
        pickingDay: DateTime(
            widget.pickingTime.year, widget.pickingTime.month + index + 1, 1),
        dayHeight: widget.dayHeight,
        width: widget.width,
      ));
    });
    _controller = PageController(initialPage: leftPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageView pageView = PageView(
      controller: _controller,
      children: items,
      onPageChanged: (position) {
        widget.onMonthChange(items[position].pickingDay);
      },
    );

    return widget.showWeekHeader
        ? Column(
            children: <Widget>[_buildWeekHeader(), Expanded(child: pageView)],
          )
        : pageView;
  }

  Widget _buildWeekHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 10, left: 5, right: 5),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('星期一', style: defaultDayStyle.copyWith(color: Colors.black)),
            Text('星期二', style: defaultDayStyle.copyWith(color: Colors.black)),
            Text('星期三', style: defaultDayStyle.copyWith(color: Colors.black)),
            Text('星期四', style: defaultDayStyle.copyWith(color: Colors.black)),
            Text('星期五', style: defaultDayStyle.copyWith(color: Colors.black)),
            Text('星期六',
                style: defaultDayStyle.copyWith(color: Colors.pink[300])),
            Text('星期日',
                style: defaultDayStyle.copyWith(color: Colors.pink[300])),
          ]),
    );
  }
}
