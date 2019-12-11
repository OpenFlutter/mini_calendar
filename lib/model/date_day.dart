import 'package:mini_calendar/model/date_month.dart';

class DateDay extends DateMonth{

  int day;

  DateDay([int year, int month, int day]) : this.dateTime(DateTime(year, month, day));

  DateDay.dateTime(DateTime time) : super.dateTime(time){
    this.day = time.day;
  }
  DateDay.now() : this.dateTime(DateTime.now());

  DateDay copyWith({int year, int month, int day}) {
    return DateDay(year ?? this.year, month ?? this.month, day ?? this.day);
  }
  DateDay subtract(Duration duration) =>
      DateDay.dateTime(time.subtract(duration));

  DateDay add(Duration duration) => DateDay.dateTime(time.add(duration));

  bool isToday() => this == DateDay.now();

  @override
  String toString() {
    String y = fourDigits(year);
    String m = twoDigits(month);
    String d = twoDigits(day);
    return "$y-$m-$d";
  }

  int get num => year * 10000 + month * 100 + day;
}
