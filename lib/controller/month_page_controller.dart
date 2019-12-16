import 'dart:async';

import '../mini_calendar.dart';

const int CACHE_SIZE = 12;

class MonthPageController<T> {
  List<MonthController<T>> _controllerList;
  MonthOption<T> _option;
  MonthOption<T> get option => _option;

  StreamController<List<DateMonth>> _monthListController = StreamController.broadcast();
  Stream<List<DateMonth>> monthListStream() => _monthListController.stream;

  List<DateMonth> _monthList = [];
  List<DateMonth> get monthList => _monthList;

  /// 初始化
  void init(MonthOption<T> option) {
    assert(option != null);
    _option = option;
    _controllerList = [];
    List.generate(CACHE_SIZE, (index) {
      addMonth(DateMonth(option.currentDay.year, option.currentDay.month - CACHE_SIZE ~/ 2 + index));
    });
  }

  /// 获取月视图控制器
  MonthController<T> getMonthController(DateMonth month) {
    int index = _monthList.indexOf(month);
    if (index == -1) return null;
    return _controllerList[index];
  }

  /// 尾部增加月份，默认添加最后一月的下一月
  void addMonth([DateMonth month]) {
    month = month ?? _monthList.last.copyWith(month: _monthList.last.month + 1);
    print(month);
    _monthList.add(month);
    if (_monthList.length > CACHE_SIZE) {
      _monthList.removeAt(0);
    } else {
      MonthController<T> controller = MonthController.init(_option.copyWith(currentMonth: month));
      _controllerList.add(controller);
    }
    reLoad();
  }

  /// 首部增加月份，默认添加第一个月的上一月
  void addFirstMonth([DateMonth month]) {
    month = month ?? _monthList.first.copyWith(month: _monthList.first.month - 1);
    _monthList.insert(0, month);
    if (_monthList.length > CACHE_SIZE) {
      _monthList.removeLast();
    } else {
      MonthController<T> controller = MonthController.init(_option.copyWith(currentMonth: month));
      _controllerList.insert(0, controller);
    }
    reLoad();
  }

  void setCurrentDay(DateDay currentDay) => _option.setCurrentDay(currentDay);
  void setFirstWeek(int week) => _option.setFirstWeek(week);
  void setEnableContinuous(bool enable) => _option.setEnableContinuous(enable);
  void setContinuousDay(DateDay firstDay, DateDay sercondDay) => _option
    ..setFirstSelectDay(firstDay)
    ..setSecondSelectDay(sercondDay);
  void setMarks(Map<DateDay, T> marks) => _option.setMarks(marks);

  /// 更新组件
  void reLoad() {
    List.generate(_controllerList.length, (index) {
      _controllerList[index]
        ..setCurrentDay(_option.currentDay)
        ..setContinuousDay(_option.firstSelectDay, _option.secondSelectDay)
        ..setEnableContinuous(_option.enableContinuous)
        ..setFirstWeek(_option.firstWeek)
        ..setMarks(_option.marks)
        ..reLoad();
    });
    _monthListController.sink.add(_monthList);
  }

  /// 关闭
  void dispose() {
    _controllerList?.forEach((c) => c.dispose());
    _monthListController?.close();
  }
}
