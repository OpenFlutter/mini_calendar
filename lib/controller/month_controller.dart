import 'dart:async';

import 'package:mini_calendar/model/month_option.dart';

import '../mini_calendar.dart';

const double SPACING = 3.0;
const double RUN_SPACING = 3.0;

class MonthController<T> {
  StreamController<MonthOption<T>> _monthController = StreamController.broadcast();

  Stream<MonthOption<T>> monthStream() => _monthController.stream;
  MonthOption<T> _option;
  get option => _option;

  /// 初始化
  MonthController.init([MonthOption<T> option]) {
    _option = option ?? MonthOption<T>();
  }

  void setMark(DateDay day, T data) {
    _option.marks[day] = data;
    _monthController.sink.add(_option);
  }

  void setCurrentMonth(DateMonth currentMonth) => _option.currentMonth = currentMonth;
  void setCurrentDay(DateDay currentDay) => _option.currentDay = currentDay;
  void setFirstWeek(int week) => _option.firstWeek = week;
  void setEnableContinuous(bool enable) => _option.enableContinuous = enable;
  void setContinuousDay(DateDay firstDay, DateDay sercondDay) => _option
    ..firstSelectDay = firstDay
    ..secondSelectDay = sercondDay;
  void setMarks(Map<DateDay, T> marks) => _option.marks = marks;

  void reLoad() => _monthController.sink.add(_option);

  void dispose() => _monthController?.close();
}
