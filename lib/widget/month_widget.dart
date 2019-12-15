///
/// 月视图
///
///
import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_calendar/model/month_option.dart';
import '../model/date_day.dart';
import '../handle.dart';
import 'day_widget.dart';

class MonthWidget<T> extends StatelessWidget {
  /// 控制器
  final MonthController<T> controller;

  /// 边距
  final EdgeInsets padding;

  /// 面板颜色
  final Color color;

  /// 面板宽度,默认屏宽
  final double width;

  /// 日组件高度
  final double dayHeight;

  /// 自定义mark
  final BuildMark<T> buildMark;

  /// 点击事件
  final OnDaySelected<T> onDaySelected;

  /// 显示日期头部
  final bool showWeekHead;

  /// 构建周抬头
  final BuildWeekHead buildWeekHead;

  /// 是否显示背景
  final bool showBackground;

  /// 构建背景
  final BuildMonthBackground buildMonthBackground;

  const MonthWidget({
    Key key,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.dayHeight,
    this.width,
    this.buildMark,
    this.onDaySelected,
    this.controller,
    this.buildWeekHead,
    this.showWeekHead = true,
    this.showBackground = true,
    this.buildMonthBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MonthController monthController = controller ?? MonthController.init()
      ..reLoad();
    DateMonth _currentMonth = controller.option.currentMonth;
    return StreamBuilder<MonthOption<T>>(
        stream: monthController.monthStream(),
        initialData: controller.option,
        builder: (BuildContext context, AsyncSnapshot<MonthOption<T>> snapshot) {
          MonthOption<T> option = snapshot?.data;
          if (option == null) return Container();
          double _width = width ?? MediaQuery.of(context).size.width;
          double _dayWidth = (_width - padding.left - padding.right - SPACING * 6 - 1.0) / 7.0;
          double _dayHeight = dayHeight ?? _dayWidth;
          int startWeek = _currentMonth.monthFirstDay.weekday;
          List<Widget> items = [];
          DateDay _time = DateDay.now();
          int headSize = (7 + startWeek - option.firstWeek) % 7;
          int endSize = 7 - (headSize + _currentMonth.maxDays) % 7;
          endSize = endSize == 7 ? 0 : endSize;
          int _hSize = ((headSize + _currentMonth.maxDays + endSize) / 7.0).floor();
          double _height = _hSize * _dayHeight + (_hSize - 1) * RUN_SPACING;

          List.generate(headSize, (index) {
            _time = DateDay(_currentMonth.monthFirstDay.year, _currentMonth.monthFirstDay.month, 1)
                .subtract(Duration(days: headSize - index));
            items.add(DayWidget<T>(
              dayTime: _time,
              style: disableDayStyle,
              height: _dayHeight,
              width: _dayWidth,
              hasMark: option.marks.containsKey(_time),
              data: option.marks[_time],
              buildMark: buildMark,
              onDaySelected: onDaySelected,
              isSelected: option.currentDay == _time,
              isContinuous: _isContinuous(_time, option),
              edit: false,
            ));
          });
          List.generate(_currentMonth.maxDays, (index) {
            _time = DateDay(_currentMonth.monthFirstDay.year, _currentMonth.monthFirstDay.month, 1)
                .add(Duration(days: index));
            items.add(DayWidget<T>(
              dayTime: _time,
              style: weekDayStyle,
              height: _dayHeight,
              width: _dayWidth,
              hasMark: option.marks.containsKey(_time),
              data: option.marks[_time],
              buildMark: buildMark,
              onDaySelected: onDaySelected,
              isSelected: option.currentDay == _time,
              isContinuous: _isContinuous(_time, option),
            ));
          });
          List.generate(endSize, (index) {
            _time = DateDay(_currentMonth.monthEndDay.year, _currentMonth.monthEndDay.month, _currentMonth.maxDays)
                .add(Duration(days: index + 1));
            items.add(DayWidget<T>(
              dayTime: _time,
              style: disableDayStyle,
              edit: false,
              height: _dayHeight,
              width: _dayWidth,
              hasMark: option.marks.containsKey(_time),
              data: option.marks[_time],
              buildMark: buildMark,
              onDaySelected: onDaySelected,
              isSelected: option.currentDay == _time,
              isContinuous: _isContinuous(_time, option),
            ));
          });

          List<Widget> lay = [];
          if (showWeekHead) {
            lay.add(Container(
              width: _width,
              padding: EdgeInsets.only(left: padding.left, right: padding.right, top: padding.top, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  int week = (option.firstWeek + index) % 7;
                  return Container(
                    alignment: Alignment.center,
                    child: buildWeekHead != null ? buildWeekHead(context, week) : defaultBuildWeekHead(context, week),
                  );
                }),
              ),
            ));
          }
          lay.add(Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: _width,
                height: _height,
                child: showBackground
                    ? (buildMonthBackground != null
                        ? buildMonthBackground(context, _currentMonth)
                        : defaultBuildMonthBackground(context, _currentMonth))
                    : Container(),
              ),
              Container(
                width: _width,
                height: _height,
                child: Wrap(spacing: SPACING, runSpacing: RUN_SPACING, children: items),
              )
            ],
          ));
          return Container(
            padding: padding,
            color: color,
            child: Column(children: lay),
          );
        });
  }

  bool _isContinuous(DateDay day, MonthOption<T> option) =>
      option.enableContinuous &&
          option.firstSelectDay != null &&
          (option.secondSelectDay == null && day == option.firstSelectDay) ||
      (option.secondSelectDay != null && day >= option.firstSelectDay && day <= option.secondSelectDay);
}
