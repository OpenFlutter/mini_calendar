import 'dart:async';

import '../model/month_option.dart';
import '../mini_calendar.dart';

const double SPACING = 3.0;
const double RUN_SPACING = 3.0;

///
/// 月视图控制器 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
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

  void setCurrentMonth(DateMonth currentMonth) => _option.setCurrentMonth(currentMonth);
  void setCurrentDay(DateDay currentDay) => _option.setCurrentDay(currentDay);
  void setFirstWeek(int week) => _option.setFirstWeek(week);
  void setEnableContinuous(bool enable) => _option.setEnableContinuous(enable);
  void setContinuousDay(DateDay firstDay, DateDay sercondDay) => _option
    ..setFirstSelectDay(firstDay)
    ..setSecondSelectDay(sercondDay);
  void setMarks(Map<DateDay, T> marks) => _option.setMarks(marks);

  void reLoad() => _monthController.sink.add(_option);

  void dispose() => _monthController?.close();
}
