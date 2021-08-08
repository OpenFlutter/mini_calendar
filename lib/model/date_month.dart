import 'date_day.dart';

///
/// 月模型 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class DateMonth {
  DateTime _time;
  DateTime get time => _time;

  late int _year;

  int get year => _year;

  late int _month;

  int get month => _month;

  late int _maxDays;

  int get maxDays => _maxDays;

  DateDay get monthFirstDay => DateDay(year, month, 1);

  DateDay get monthEndDay => DateDay(year, month, maxDays);

  DateMonth(int year, [int month = 1])
      : this.dateTime(DateTime(year, month, 1));

  DateMonth.dateTime(this._time) {
    _year = this.time.year;
    _month = this.time.month;
    _maxDays = DateTime(this.time.year, this.time.month + 1, 1)
        .add(Duration(days: -1))
        .day;
  }

  DateMonth.now() : this.dateTime(DateTime.now());

  DateMonth copyWith({int? year, int? month}) {
    return DateMonth(year ?? this.year, month ?? this.month);
  }

  DateMonth subtract(Duration duration) =>
      DateMonth.dateTime(time.subtract(duration));

  DateMonth add(Duration duration) => DateMonth.dateTime(time.add(duration));

  int get weekday => time.weekday;

  @override
  String toString({String yearSuffix = '-', String monthSuffix = ''}) {
    String y = fourDigits(year);
    String m = twoDigits(month);
    return "$y$yearSuffix$m$monthSuffix";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DateMonth && num == other.num;

  bool operator >(Object other) =>
      other is DateMonth && runtimeType == other.runtimeType && num > other.num;

  bool operator <(Object other) =>
      other is DateMonth && runtimeType == other.runtimeType && num < other.num;

  bool operator >=(Object other) =>
      other is DateMonth &&
      runtimeType == other.runtimeType &&
      num >= other.num;

  bool operator <=(Object other) =>
      other is DateMonth &&
      runtimeType == other.runtimeType &&
      num <= other.num;

  bool contain(DateDay day) =>
      day.year == this._year && day.month == this._month;

  @override
  int get hashCode => num.hashCode;

  String fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  int get num => year * 100 + month;
}
