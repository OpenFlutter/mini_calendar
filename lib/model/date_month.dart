import 'date_day.dart';

class DateMonth {
  DateTime time;

  int year;

  int month;

  int maxDays;

  DateDay get monthFirstDay => DateDay(year, month, 1);

  DateDay get monthEndDay => DateDay(year, month, maxDays);

  DateMonth([int year, int month]) : this.dateTime(DateTime(year, month, 1));

  DateMonth.dateTime(this.time) {
    year = this.time.year;
    month = this.time.month;
    maxDays = DateTime(this.time.year, this.time.month + 1, 1)
        .add(Duration(days: -1))
        .day;
  }
  DateMonth.now() : this.dateTime(DateTime.now());

  DateMonth copyWith({int year, int month}) {
    return DateMonth(year ?? this.year, month ?? this.month);
  }

  DateMonth subtract(Duration duration) =>
      DateMonth.dateTime(time.subtract(duration));

  DateMonth add(Duration duration) => DateMonth.dateTime(time.add(duration));

  int get weekday => time.weekday;

  @override
  String toString() {
    String y = fourDigits(year);
    String m = twoDigits(month);
    return "$y-$m";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DateMonth && num == other.num;

  bool operator >(Object other) =>
      other is DateMonth && runtimeType == other.runtimeType && num > other.num;

  bool operator <(Object other) =>
      other is DateMonth && runtimeType == other.runtimeType && num < other.num;

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
