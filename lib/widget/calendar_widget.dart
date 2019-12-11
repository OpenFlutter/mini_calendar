import 'package:flutter/material.dart';
import 'package:mini_calendar/handle.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_calendar/model/date_day.dart';

import 'month_widget.dart';

///
class MiniCalender<T> extends StatelessWidget {
  /// 当前选择的日期
  final DateDay currentDay;

  /// 当前选中的月份
  final DateDay currentMonth;

  /// 最小日期
  final DateDay minTime;

  /// 最大日期
  final DateDay maxTime;

  /// 日控件高度
  final double dayHeight;

  /// 日历宽度
  final double width;

  /// 月份滑动改变
  final ValueChanged<DateDay> onMonthChange;

  /// 显示星期
  final bool showWeekHeader;

  /// 标记集合
  final Map<DateDay, T> marks;

  final BuildMark<T> buildMark;

  /// 日期选择事件
  final OnDaySelected<T> onDaySelected;

  MiniCalender({
    Key key,
    this.currentDay,
    this.minTime,
    this.maxTime,
    this.onMonthChange,
    this.dayHeight,
    this.width = double.infinity,
    this.showWeekHeader = true,
    this.marks = const {},
    this.buildMark,
    this.onDaySelected,
    this.currentMonth,
  }) : super(key: key);

  List<DateDay> months = [];
  PageController _controller;
  int _leftEndPosition = 1;
  int _rightEndPosition = 1;
  DateDay _currentDay;
  DateDay _currentMonth;

  int _position;

  bool goToDay(DateDay day) {
    for (int index = 0; index < months.length; index++) {
      if (index !=_position && months[index].year == day.year && months[index].month == day.month) {
        _controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        return true;
      }
    }
    return false;
  }

  bool next() {
    if (_position == (_leftEndPosition + _rightEndPosition)) return false;
    _controller.animateToPage(++_position, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    return true;
  }

  bool prev() {
    if (_position == 0) return false;
    _controller.animateToPage(--_position, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    return true;
  }

  void initData() {
    DateDay _startTime = minTime;
    DateDay _endTime = maxTime;
    _currentDay = currentDay != null ? currentDay.copyWith() : DateDay.now();
    _currentMonth = currentMonth != null ? currentMonth.copyWith() : _currentDay.copyWith();

    if (_startTime == null || _startTime > _currentDay) {
      _startTime = _currentDay.monthFirstDay;
    }
    if (_endTime == null || _endTime < _currentDay) {
      _endTime = _currentDay.monthEndDay;
    }
    _leftEndPosition = (_currentMonth.year - _startTime.year) * 12 + _currentMonth.month - _startTime.month;
    _position = _leftEndPosition;
    _rightEndPosition = (_endTime.year - _currentMonth.year) * 12 + _endTime.month - _startTime.month;

    List.generate(_leftEndPosition, (index) {
      months.add(_currentMonth.copyWith(month: _currentMonth.month - _leftEndPosition + index, day: 1));
    });
    months.add(_currentMonth.copyWith());
    List.generate(_rightEndPosition, (index) {
      months.add(_currentMonth.copyWith(month: _currentMonth.month + index + 1, day: 1));
    });
    _controller = PageController(initialPage: _position);
  }

  @override
  Widget build(BuildContext context) {
    initData();
    PageView pageView = PageView(
      controller: _controller,
      children: months
          .map(
            (month) => MonthWidget(
              currentMonth: month,
              currentDay: _currentDay,
              dayHeight: dayHeight,
              width: width,
              buildMark: buildMark,
              marks: marks,
              onDaySelected: (day, data) {
                _currentDay = day.copyWith();
                if (onDaySelected != null) onDaySelected(_currentDay, data);
              },
            ),
          )
          .toList(),
      onPageChanged: (position) {
        this._position = position;
        _currentMonth = months[this._position].copyWith();
        if (onMonthChange != null) onMonthChange(_currentMonth);
      },
    );

    return showWeekHeader
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
            Text('星期六', style: defaultDayStyle.copyWith(color: Colors.pink[300])),
            Text('星期日', style: defaultDayStyle.copyWith(color: Colors.pink[300])),
          ]),
    );
  }
}
