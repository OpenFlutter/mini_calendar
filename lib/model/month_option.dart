import 'date_day.dart';
import 'date_month.dart';

///
/// 月视图控制器参数 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class MonthOption<T> {
  /// 当前选中日期
  DateDay _currentDay;

  DateDay get currentDay => _currentDay;
  void setCurrentDay(DateDay value) => _currentDay = value;

  /// 所在月份
  DateMonth _currentMonth;
  DateMonth get currentMonth => _currentMonth;
  void setCurrentMonth(DateMonth value) => _currentMonth = value;

  /// 第一列是星期几（1，2，3，4，5，6，7）
  int _firstWeek;
  int get firstWeek => _firstWeek;
  void setFirstWeek(int value) => _firstWeek = value;

  /// 第一个选择的时间
  DateDay _firstSelectDay;
  DateDay get firstSelectDay => _firstSelectDay;
  void setFirstSelectDay(DateDay value) => _firstSelectDay = value;

  /// 第二个选择的时间
  DateDay _secondSelectDay;
  DateDay get secondSelectDay => _secondSelectDay;
  void setSecondSelectDay(DateDay value) => _secondSelectDay = value;

  /// 是否开启连续选择
  bool _enableContinuous;
  bool get enableContinuous => _enableContinuous;
  void setEnableContinuous(bool value) => _enableContinuous = value;

  /// 标记
  Map<DateDay, T> _marks;
  Map<DateDay, T> get marks => _marks;
  void setMarks(Map<DateDay, T> value) => _marks = value;
  void addMark(DateDay day, T data) => _marks[day] = data;

  /// 显示的最大日期
  DateDay _maxDay;
  DateDay get maxDay => _maxDay;

  /// 显示的最小日期
  DateDay _minDay;
  DateDay get minDay => _minDay;

  /// 初始化 <br/>
  /// [currentDay] - 选择的日期 <br/>
  /// [currentMonth] - 当前月份 <br/>
  /// [firstWeek] - 第一列显示的星期 [1,7] <br/>
  /// [enableContinuous] - 是否支持连选 <br/>
  /// [firstSelectDay] - 连选第一个日期<br/>
  /// [secondSelectDay] - 连选第二个日期<br/>
  /// [marks] - 标记<br/>
  /// [minDay] - 可选的最小日期<br/>
  /// [maxDay] - 可选的最大日期<br/>
  MonthOption({
    DateDay currentDay,
    DateMonth currentMonth,
    int firstWeek = 7,
    DateDay firstSelectDay,
    DateDay secondSelectDay,
    bool enableContinuous = false,
    Map<DateDay, T> marks = const {},
    DateDay minDay,
    DateDay maxDay,
  }) {
    this._currentDay = currentDay;
    this._currentMonth = currentMonth ??
        (this.currentDay == null ? DateMonth.now() : DateMonth(this.currentDay.year, this.currentDay.month));
    this._firstWeek = firstWeek;
    this._enableContinuous = enableContinuous;
    this._firstSelectDay = firstSelectDay;
    this._secondSelectDay = secondSelectDay;
    this._marks = marks;
    this._minDay = minDay;
    this._maxDay = maxDay;
  }

  /// copy对象 <br/>
  /// [currentDay] - 选择的日期 <br/>
  /// [currentMonth] - 当前月份 <br/>
  /// [firstWeek] - 第一列显示的星期 [1,7] <br/>
  /// [enableContinuous] - 是否支持连选 <br/>
  /// [firstSelectDay] - 连选第一个日期<br/>
  /// [secondSelectDay] - 连选第二个日期<br/>
  /// [marks] - 标记<br/>
  /// [minDay] - 可选的最小日期<br/>
  /// [maxDay] - 可选的最大日期<br/>
  MonthOption<T> copyWith({
    DateDay currentDay,
    DateMonth currentMonth,
    int firstWeek,
    DateDay firstSelectDay,
    DateDay secondSelectDay,
    bool enableContinuous,
    Map<DateDay, T> marks,
    DateDay minDay,
    DateDay maxDay,
  }) {
    return MonthOption<T>(
      currentDay: currentDay ?? this.currentDay,
      currentMonth: currentMonth ?? this.currentMonth,
      firstSelectDay: firstSelectDay ?? this.firstSelectDay,
      firstWeek: firstWeek ?? this.firstWeek,
      secondSelectDay: secondSelectDay ?? this.secondSelectDay,
      enableContinuous: enableContinuous ?? this.enableContinuous,
      marks: marks ?? this.marks,
      minDay: minDay ?? this.minDay,
      maxDay: maxDay ?? this.maxDay,
    );
  }
}
