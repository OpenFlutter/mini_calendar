class DateDay {
  DateTime _time;
  DateTime get time => _time;

  int _year;
  int get year => _year;

  int _month;
  int get month => _month;

  int _day;
  int get day => _day;

  int _maxDays;
  int get maxDays => _maxDays;

  DateDay get monthFirstDay => DateDay(year, month, 1);

  DateDay get monthEndDay => DateDay(year, month, maxDays);

  DateDay([int year, int month, int day]) : this._(DateTime(year, month, day));

  DateDay._([this._time]) {
    _year = _time.year;
    _month = _time.month;
    _day = _time.day;
    _maxDays = DateTime(time.year, time.month + 1, 1).add(Duration(days: -1)).day;
  }

  DateDay.dateTime(DateTime time) : this._(time);

  DateDay copyWith({int year, int month, int day}) {
    return DateDay(year ?? this.year, month ?? this.month, day ?? this.day);
  }

  DateDay.now() : this._(DateTime.now());

  bool isToday() => this == DateDay.now();

  DateDay subtract(Duration duration) => DateDay.dateTime(_time.subtract(duration));

  DateDay add(Duration duration) => DateDay.dateTime(_time.add(duration));

  int get weekday => _time.weekday;

  @override
  String toString() {
    String y = _fourDigits(year);
    String m = _twoDigits(month);
    String d = _twoDigits(day);
    return "$y-$m-$d";
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is DateDay && num == other.num;

  bool operator >(Object other) => other is DateDay && runtimeType == other.runtimeType && num > other.num;

  bool operator <(Object other) => other is DateDay && runtimeType == other.runtimeType && num < other.num;

  @override
  int get hashCode => num.hashCode;

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  int get num => year * 10000 + month * 100 + day;
}
