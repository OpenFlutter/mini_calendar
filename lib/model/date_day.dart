import 'date_month.dart';

///
/// 日模型 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class DateDay extends DateMonth {
  late int _day;
  int get day => _day;

  DateDay(int year, int month, [int day = 1])
      : this.dateTime(DateTime(year, month, day));

  DateDay.dateTime(DateTime time) : super.dateTime(time) {
    this._day = time.day;
  }

  DateDay.now() : this.dateTime(DateTime.now());

  DateDay copyWith({int? year, int? month, int? day}) {
    return DateDay(year ?? this.year, month ?? this.month, day ?? this.day);
  }

  DateDay subtract(Duration duration) =>
      DateDay.dateTime(time.subtract(duration));

  DateDay add(Duration duration) => DateDay.dateTime(time.add(duration));

  bool isToday() => this == DateDay.now();

  bool inMonth(DateMonth month) =>
      year == month.year && this.month == month.month;

  @override
  String toString(
      {String yearSuffix = '-',
      String monthSuffix = '-',
      String daySuffix = ''}) {
    String y = fourDigits(year);
    String m = twoDigits(month);
    String d = twoDigits(day);
    return "$y$yearSuffix$m$monthSuffix$d$daySuffix";
  }

  int get num => year * 10000 + month * 100 + day;
}
