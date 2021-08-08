import 'dart:async';

import 'package:flutter/material.dart';

import '../mini_calendar.dart';

const int CACHE_SIZE = 12;

///
/// 翻页日历控制器 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class MonthPageController<T> {
  late List<MonthController<T>> _controllerList;
  late MonthOption<T> _option;
  MonthOption<T> get option => _option;

  /// 页面控制器
  PageController? _pageController;

  StreamController<List<DateMonth>> _monthListController =
      StreamController.broadcast();
  Stream<List<DateMonth>> monthListStream() => _monthListController.stream;
  List<DateMonth> _monthList = [];
  List<DateMonth> get monthList => _monthList;

  StreamController<int> _positionController = StreamController.broadcast();
  Stream<int> positionStream() => _positionController.stream;
  late int _position;
  int get position => _position;

  /// 页面位置更改
  void changePosition(int position) {
    _position = position;
    _positionController.sink.add(position);
  }

  /// 初始化
  void init(MonthOption<T> option, {PageController? pageController}) {
    _option = option;
    _controllerList = [];
    _position = CACHE_SIZE ~/ 2;
    _pageController = pageController;
    DateDay _day = option.currentDay ?? DateDay.now();
    List.generate(CACHE_SIZE, (index) {
      addMonth(DateMonth(_day.year, _day.month - CACHE_SIZE ~/ 2 + index));
    });

    if (_pageController != null) {
      _pageController!.addListener(() {
        double position = _pageController!.position.pixels;
        if (position == 0) {
          addFirstMonth();
          _position = 1;
          _pageController!.jumpToPage(_position);
        } else if (position == _pageController!.position.maxScrollExtent) {
          addMonth();
          if (monthList.length == CACHE_SIZE) {
            _position = CACHE_SIZE - 2;
            _pageController!.jumpToPage(_position);
          }
        }
      });
    }
  }

  /// 获取月视图控制器
  MonthController<T> getMonthController(DateMonth month) {
    int index = _monthList.indexOf(month);
    // if (index == -1) return null;
    return _controllerList[index];
  }

  /// 尾部增加月份，默认添加最后一月的下一月
  void addMonth([DateMonth? month]) {
    month = month ?? _monthList.last.copyWith(month: _monthList.last.month + 1);
    _monthList.add(month);
    if (_monthList.length > CACHE_SIZE) {
      _monthList.removeAt(0);
    } else {
      MonthController<T> controller =
          MonthController.init(_option.copyWith(currentMonth: month));
      _controllerList.add(controller);
    }
    reLoad();
  }

  /// 首部增加月份，默认添加第一个月的上一月
  void addFirstMonth([DateMonth? month]) {
    month =
        month ?? _monthList.first.copyWith(month: _monthList.first.month - 1);
    _monthList.insert(0, month);
    if (_monthList.length > CACHE_SIZE) {
      _monthList.removeLast();
    } else {
      MonthController<T> controller =
          MonthController.init(_option.copyWith(currentMonth: month));
      _controllerList.insert(0, controller);
    }
    reLoad();
  }

  void setCurrentDay(DateDay currentDay) => _option.setCurrentDay(currentDay);
  void setFirstWeek(int week) => _option.setFirstWeek(week);
  void setEnableContinuous(bool enable) => _option.setEnableContinuous(enable);

  void setEnableMultiple(bool enable) => _option.setEnableMultiple(enable);

  void setContinuousDay(DateDay? firstDay, DateDay? secondDay) => _option
    ..setFirstSelectDay(firstDay)
    ..setSecondSelectDay(secondDay);

  void setMultipleDays(List<DateDay> days) => _option.setMultipleDays(days);

  void setMarks(Map<DateDay, T> marks) => _option.setMarks(marks);

  /// 更新组件
  void reLoad() {
    List.generate(_controllerList.length, (index) {
      _controllerList[index]
        ..setCurrentDay(_option.currentDay)
        ..setEnableContinuous(_option.enableContinuous)
        ..setContinuousDay(_option.firstSelectDay, _option.secondSelectDay)
        ..setFirstWeek(_option.firstWeek)
        ..setMarks(_option.marks)
        ..setEnableMultiple(_option.enableMultiple)
        ..setMultipleDays(_option.multipleDays)
        ..reLoad();
    });
    _monthListController.sink.add(_monthList);
  }

  /// 关闭
  void dispose() {
    _controllerList.forEach((c) => c.dispose());
    _monthListController.close();
    _positionController.close();
    _pageController?.dispose();
  }

  /// 上一月
  void last() => _pageController?.animateToPage(--_position,
      duration: Duration(milliseconds: 200), curve: Curves.ease);

  /// 下一月
  void next() => _pageController?.animateToPage(++_position,
      duration: Duration(milliseconds: 200), curve: Curves.ease);

  /// 跳转到指定月份
  void goto(DateMonth month) {
    if (month == _monthList[_position]) return;
    _position = CACHE_SIZE ~/ 2;
    _monthList.clear();
    _controllerList.clear();
    List.generate(CACHE_SIZE, (index) {
      addMonth(DateMonth(month.year, month.month - CACHE_SIZE ~/ 2 + index));
    });
    _pageController?.animateToPage(_position,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    changePosition(_position);
  }
}
