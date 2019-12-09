import 'package:flutter_calendar/handle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("DateHanddle", () {
    DateHandle dateHandle = DateHandle(DateTime(2019, 2, 2));
    expect(dateHandle.maxDays, equals(28));
    expect(dateHandle.startDay, equals(DateTime(2019, 2, 1)));
    expect(dateHandle.endDay, equals(DateTime(2019, 2, 28)));
  });
}
