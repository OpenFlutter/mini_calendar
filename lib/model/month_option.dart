import 'date_day.dart';
import 'date_month.dart';

///
/// 月视图控制器参数 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class MonthOption<T> {
  /// 当前选中日期
  DateDay? _currentDay;

  DateDay? get currentDay => _currentDay;

  void setCurrentDay(DateDay? value) => _currentDay = value;

  /// 所在月份
  DateMonth? _currentMonth;

  DateMonth? get currentMonth => _currentMonth;

  void setCurrentMonth(DateMonth? value) => _currentMonth = value;

  /// 第一列是星期几（1，2，3，4，5，6，7）
  late int _firstWeek;

  int get firstWeek => _firstWeek;

  void setFirstWeek(int value) => _firstWeek = value;

  /// 第一个选择的时间
  DateDay? _firstSelectDay;

  DateDay? get firstSelectDay => _firstSelectDay;

  void setFirstSelectDay(DateDay? value) => _firstSelectDay = value;

  /// 第二个选择的时间
  DateDay? _secondSelectDay;

  DateDay? get secondSelectDay => _secondSelectDay;

  void setSecondSelectDay(DateDay? value) => _secondSelectDay = value;

  /// 是否开启连续选择
  late bool _enableContinuous;

  bool get enableContinuous => _enableContinuous;

  void setEnableContinuous(bool value) => _enableContinuous = value;

  /// 在连续中
  bool inContinuousDay(DateDay day) =>
      _enableContinuous &&
          _firstSelectDay != null &&
          (_secondSelectDay == null && day == _firstSelectDay) ||
      (_secondSelectDay != null &&
          day >= _firstSelectDay! &&
          day <= _secondSelectDay!);

  /// 标记
  late Map<DateDay, T> _marks;

  Map<DateDay, T> get marks => _marks;

  void setMarks(Map<DateDay, T> value) => _marks = value;

  void addMark(DateDay day, T data) => _marks[day] = data;

  /// 显示的最大日期
  DateDay? _maxDay;

  DateDay? get maxDay => _maxDay;

  /// 显示的最小日期
  DateDay? _minDay;

  DateDay? get minDay => _minDay;

  /// 可选的日期，为null时不限制
  List<DateDay>? _enableDays;

  /// 当前日期是否可用
  bool enableDay(DateDay day, DateMonth month) =>
      day.inMonth(month) &&
      ((_minDay != null && _minDay! <= day) || _minDay == null) &&
      ((_maxDay != null && _maxDay! >= day) || _maxDay == null) &&
      (_enableDays == null || _enableDays!.contains(day));

  /// 是否开启多选，开启多选后连选失效
  late bool _enableMultiple;

  bool get enableMultiple => _enableMultiple;

  void setEnableMultiple(bool value) => _enableMultiple = value;

  late List<DateDay> _multipleDays;

  List<DateDay> get multipleDays => _multipleDays;

  void setMultipleDays(List<DateDay> days) => _multipleDays = days;

  void add(DateDay day) {
    _multipleDays.add(day);
  }

  bool remove(DateDay day) {
    return _multipleDays.remove(day);
  }

  /// 在多选中
  bool inMultipleDay(DateDay day) {
    if (!_enableMultiple) return false;
    return multipleDays.any((item) => item == day);
  }

  /// 初始化 <br/>
  /// [currentDay] - 选择的日期 <br/>
  /// [currentMonth] - 当前月份 <br/>
  /// [firstWeek] - 第一列显示的星期 [1,7] <br/>
  /// [enableContinuous] - 是否支持连选 <br/>
  /// [firstSelectDay] - 连选第一个日期<br/>
  /// [secondSelectDay] - 连选第二个日期<br/>
  /// [enableMultiple] - 是否开启多选，开启多选后连选失效 <br/>
  /// [enableDays] - 限制可选的日期，默认不限制 <br/>
  /// [multipleDays] - 多选的默认日期 <br/>
  /// [marks] - 标记<br/>
  /// [minDay] - 可选的最小日期<br/>
  /// [maxDay] - 可选的最大日期<br/>
  MonthOption({
    DateDay? currentDay,
    DateMonth? currentMonth,
    int firstWeek = 7,
    DateDay? firstSelectDay,
    DateDay? secondSelectDay,
    bool enableContinuous = false,
    Map<DateDay, T> marks = const {},
    List<DateDay>? multipleDays,
    List<DateDay>? enableDays,
    bool enableMultiple = false,
    DateDay? minDay,
    DateDay? maxDay,
  }) {
    this._currentDay = currentDay;
    this._currentMonth = currentMonth ??
        (this.currentDay == null
            ? DateMonth.now()
            : DateMonth(this.currentDay!.year, this.currentDay!.month));
    this._firstWeek = firstWeek;
    this._enableContinuous = enableContinuous;
    this._enableMultiple = enableMultiple;
    this._firstSelectDay = firstSelectDay;
    this._secondSelectDay = secondSelectDay;
    this._multipleDays = multipleDays ?? [];
    this._enableDays = enableDays;
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
  /// [enableMultiple] - 是否开启多选，开启多选后连选失效 <br/>
  /// [enableDays] - 限制可选的日期，默认不限制 <br/>
  /// [multipleDays] - 多选的默认日期 <br/>
  /// [marks] - 标记<br/>
  /// [minDay] - 可选的最小日期<br/>
  /// [maxDay] - 可选的最大日期<br/>
  MonthOption<T> copyWith({
    DateDay? currentDay,
    DateMonth? currentMonth,
    int? firstWeek,
    DateDay? firstSelectDay,
    DateDay? secondSelectDay,
    bool? enableContinuous,
    bool? enableMultiple,
    Map<DateDay, T>? marks,
    List<DateDay>? multipleDays,
    List<DateDay>? enableDays,
    DateDay? minDay,
    DateDay? maxDay,
  }) {
    return MonthOption<T>(
      currentDay: currentDay ?? this.currentDay,
      currentMonth: currentMonth ?? this.currentMonth,
      firstSelectDay: firstSelectDay ?? this.firstSelectDay,
      firstWeek: firstWeek ?? this.firstWeek,
      secondSelectDay: secondSelectDay ?? this.secondSelectDay,
      enableContinuous: enableContinuous ?? this.enableContinuous,
      enableMultiple: enableMultiple ?? this.enableMultiple,
      multipleDays: multipleDays ?? this._multipleDays,
      enableDays: enableDays ?? this._enableDays,
      marks: marks ?? this.marks,
      minDay: minDay ?? this.minDay,
      maxDay: maxDay ?? this.maxDay,
    );
  }
}
