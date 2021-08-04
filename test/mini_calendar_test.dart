import 'package:flutter_test/flutter_test.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_calendar/model/date_day.dart';

void main() {
  print(DateDay(2019, 12, 12).isToday());
  print(DateDay(2019, 12, 11).isToday());
  test("DateDay", () {
    expect(DateDay(2019, 12, 12).isToday(), true);
    expect(DateDay(2019, 12, 11).isToday(), false);
    expect(DateDay(2019, 12, 10) > DateDay(2019, 12, 9), true);
    expect(DateDay(2019, 12, 10) < DateDay(2019, 12, 11), true);
    expect(DateDay(2019, 2, 29) == DateDay(2019, 3, 1), true);
    expect(DateDay(2019, 3, 29).monthFirstDay == DateDay(2019, 3, 1), true);
    expect(DateDay(2019, 3, 29).monthEndDay == DateDay(2019, 3, 31), true);
    expect(DateDay(2019, 3, 29).maxDays == 31, true);
  });
}
