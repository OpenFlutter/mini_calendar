import 'package:flutter/material.dart';

import '../model/date_month.dart';
import '../controller/month_controller.dart';
import '../model/month_option.dart';
import '../model/date_day.dart';
import '../model/calendar_i18n_model.dart';
import '../handle.dart';

///
/// 月视图 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class MonthWidget<T> extends StatelessWidget {
  /// 控制器
  final MonthController<T>? controller;

  /// 边距
  final EdgeInsets padding;

  /// 面板颜色
  final Color color;

  /// 日历面板宽度
  final double? width;

  /// 日历面板高度
  final double? height;

  /// 自定义mark
  final BuildMark<T>? buildMark;

  /// 点击事件
  final OnDaySelected<T>? onDaySelected;

  /// 显示星期头部
  final bool showWeekHead;

  /// 星期头部背景色
  final Color weekHeadColor;

  /// 构建星期头部
  final BuildWeekHead? buildWeekHead;

  /// 是否显示背景
  final bool showBackground;

  /// 构建背景
  final BuildWithMonth? buildMonthBackground;

  /// 是否显示月视图头部
  final bool showMonthHead;

  /// 月视图头部背景色
  final Color monthHeadColor;

  /// 工作日字体颜色
  final Color weekColor;

  /// 周末字体颜色
  final Color weekendColor;

  /// 构建月视图头部
  final BuildWithMonth? buildMonthHead;

  /// 默认构建日视图  <br/>
  /// [context] - 上下文  <br/>
  /// [height] - 控件高  <br/>
  /// [width] - 控件宽  <br/>
  /// [dayTime] - 当前日期 <br/>
  /// [enableSelect] - 是否可选 <br/>
  /// [hasMark] - 是否含有标记 <br/>
  /// [markData] - 标记内容 <br/>
  /// [weekColor] - 工作日颜色 <br/>
  /// [weekendColor] - 周末颜色 <br/>
  /// [isSelected] - 是否被单选 <br/>
  /// [isContinuous] - 是否被连选 <br/>
  /// [isMultiple] - 是否被多选 <br/>
  /// [buildMark] - 自定义构建mark <br/>
  /// [onDaySelected] - 选择事件 <br/>
  final BuildWithDay<T>? buildDayItem;

  /// 连选监听
  final OnContinuousSelectListen? onContinuousSelectListen;

  /// 多选监听
  final ValueChanged<List<DateDay>>? onMultipleSelectListen;

  /// 国际化语言类型
  final CalendarLocaleType localeType;

  const MonthWidget({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
    this.width,
    this.buildMark,
    this.onDaySelected,
    this.controller,
    this.buildWeekHead,
    this.showWeekHead = true,
    this.showBackground = true,
    this.buildMonthBackground,
    this.buildDayItem,
    this.onContinuousSelectListen,
    this.onMultipleSelectListen,
    this.showMonthHead = true,
    this.buildMonthHead,
    this.height,
    this.weekHeadColor = Colors.transparent,
    this.monthHeadColor = Colors.transparent,
    this.weekColor = const Color(0xa6000000),
    this.weekendColor = const Color(0xffFF4081),
    this.localeType = CalendarLocaleType.zh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MonthController<T> _monthController =
        controller ?? MonthController<T>.init()
          ..reLoad();
    DateMonth _currentMonth = _monthController.option?.currentMonth;
    return StreamBuilder<MonthOption<T>>(
        stream: _monthController.monthStream(),
        initialData: _monthController.option,
        builder:
            (BuildContext context, AsyncSnapshot<MonthOption<T>> snapshot) {
          MonthOption<T>? _option = snapshot.data;
          if (_option == null) return Container();
          int _startWeek = _currentMonth.monthFirstDay.weekday;
          int _headSize = (7 + _startWeek - _option.firstWeek) % 7;
          int _endSize = 7 - (_headSize + _currentMonth.maxDays) % 7;
          _endSize = _endSize == 7 ? 0 : _endSize;
          int _hSize =
              ((_headSize + _currentMonth.maxDays + _endSize) / 7.0).floor();

          double _width = width ?? MediaQuery.of(context).size.width;
          double _height = height ?? _width * 5.5 / 7.0;
          double _dayWidth =
              ((_width - padding.left - padding.right - 1.0) / 7.0);
          double _dayHeight =
              ((_height - padding.top - padding.bottom - 1.0) / _hSize);

          List<DateDay> _days = [];

          List.generate(_headSize, (index) {
            _days.add(DateDay(_currentMonth.monthFirstDay.year,
                    _currentMonth.monthFirstDay.month, 1)
                .subtract(Duration(days: _headSize - index)));
          });
          List.generate(_currentMonth.maxDays, (index) {
            _days.add(DateDay(_currentMonth.monthFirstDay.year,
                    _currentMonth.monthFirstDay.month, 1)
                .add(Duration(days: index)));
          });
          List.generate(_endSize, (index) {
            _days.add(DateDay(_currentMonth.monthEndDay.year,
                    _currentMonth.monthEndDay.month, _currentMonth.maxDays)
                .add(Duration(days: index + 1)));
          });

          List<Widget> lay = [];
          if (showMonthHead) {
            lay.add(Container(
              width: _width,
              color: monthHeadColor,
              padding: EdgeInsets.only(
                  left: padding.left, right: padding.right, top: 5, bottom: 5),
              child: buildMonthHead != null
                  ? buildMonthHead!(
                      context, _width, double.infinity, _currentMonth)
                  : defaultBuildMonthHead(context, _currentMonth),
            ));
          }
          if (showWeekHead) {
            lay.add(Container(
              width: _width,
              color: weekHeadColor,
              padding: EdgeInsets.only(
                  left: padding.left, right: padding.right, top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  int week = (_option.firstWeek + index) % 7;
                  return Container(
                    alignment: Alignment.center,
                    child: buildWeekHead != null
                        ? buildWeekHead!(context, week)
                        : defaultBuildWeekHead(context, week,
                            localeType: localeType),
                  );
                }),
              ),
            ));
          }
          lay.add(
            Container(
                height: _height,
                width: _width,
                color: color,
                padding: padding,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height,
                      child: showBackground
                          ? (buildMonthBackground != null
                              ? buildMonthBackground!(
                                  context, _width, _height, _currentMonth)
                              : defaultBuildMonthBackground(
                                  context, _currentMonth))
                          : Container(),
                    ),
                    Container(
                      width: _width,
                      height: _height,
                      child: Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          children: _days.map((_time) {
                            bool enableSelect =
                                _option.enableDay(_time, _currentMonth);
                            bool isContinuous = _option.inContinuousDay(_time);
                            bool isMultiple = _option.inMultipleDay(_time);
                            return buildDayItem == null
                                ? defaultBuildDayItem<T>(
                                    context,
                                    _time,
                                    weekColor: weekColor,
                                    weekendColor: weekendColor,
                                    enableSelect: enableSelect,
                                    height: _dayHeight,
                                    width: _dayWidth,
                                    first: isContinuous &&
                                        _time == _option.firstSelectDay,
                                    end: isContinuous &&
                                        (_option.secondSelectDay == null ||
                                            _time == _option.secondSelectDay),
                                    hasMark: _option.marks.containsKey(_time),
                                    markData: _option.marks[_time],
                                    buildMark: buildMark,
                                    onDaySelected: (day, data, enable) =>
                                        _onDaySelected(day, data, _option,
                                            _monthController, enable),
                                    isSelected: _option.currentDay == _time,
                                    isMultiple: isMultiple,
                                    isContinuous: isContinuous,
                                    localeType: localeType,
                                  )
                                : buildDayItem!(
                                    context,
                                    _time,
                                    weekColor: weekColor,
                                    weekendColor: weekendColor,
                                    enableSelect: enableSelect,
                                    height: _dayHeight,
                                    width: _dayWidth,
                                    hasMark: _option.marks.containsKey(_time),
                                    markData: _option.marks[_time],
                                    buildMark: buildMark,
                                    onDaySelected: (day, data, enable) =>
                                        _onDaySelected(day, data, _option,
                                            _monthController, enable),
                                    isSelected: _option.currentDay == _time,
                                    isContinuous: isContinuous,
                                  );
                          }).toList()),
                    )
                  ],
                )),
          );
          return Column(children: lay);
        });
  }

  void _onDaySelected(DateDay day, T? data, MonthOption<T> option,
      MonthController monthController, bool enable) {
    print("$day,多选：${option.enableMultiple}，连续：${option.enableContinuous}");
    if (!enable && onDaySelected != null) {
      onDaySelected!(day, data, enable);
      return;
    }
    if (option.enableMultiple) {
      if (onMultipleSelectListen != null) {
        bool selected = option.inMultipleDay(day);
        if (selected)
          monthController
            ..remove(day)
            ..reLoad();
        else
          monthController
            ..add(day)
            ..reLoad();
        onMultipleSelectListen!(option.multipleDays);
      }
    } else if (option.enableContinuous) {
      DateDay? firstDay = option.firstSelectDay;
      DateDay? secondDay = option.secondSelectDay;
      if (firstDay == null) {
        firstDay = day.copyWith();
        secondDay = null;
      } else if (secondDay == null) {
        if (firstDay > day) {
          secondDay = firstDay.copyWith();
          firstDay = day.copyWith();
        } else {
          secondDay = day.copyWith();
        }
      } else {
        if (day >= firstDay && day <= secondDay) {
          secondDay = day.copyWith();
        } else {
          firstDay = null;
          secondDay = null;
        }
      }

      if (onContinuousSelectListen != null) {
        monthController
          ..setContinuousDay(firstDay, secondDay)
          ..reLoad();
        onContinuousSelectListen!(firstDay, secondDay);
      }
    } else {
      if (onDaySelected != null) {
        monthController
          ..setCurrentDay(day.copyWith())
          ..reLoad();
        onDaySelected!(day.copyWith(), data, true);
      }
    }
  }

//  bool _enableEnableSelect(DateDay day, DateMonth month, MonthOption<T> option) {
//    return day.inMonth(month) &&
//        ((option.minDay != null && option.minDay <= day) || option.minDay == null) &&
//        ((option.maxDay != null && option.maxDay >= day) || option.maxDay == null);
//  }
//
//  bool _isContinuous(DateDay day, MonthOption<T> option) =>
//      option.enableContinuous &&
//          option.firstSelectDay != null &&
//          (option.secondSelectDay == null && day == option.firstSelectDay) ||
//      (option.secondSelectDay != null && day >= option.firstSelectDay && day <= option.secondSelectDay);

}
