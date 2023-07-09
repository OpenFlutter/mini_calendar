import 'dart:math';

import 'package:flutter/material.dart';

import 'package:mini_calendar/mini_calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  List<Widget> months = [];
  List<MonthController<String>> controllers = [];

  @override
  void initState() {
    List.generate(12, (index) {
      controllers.add(MonthController.init(MonthOption<String>(
          currentDay: DateDay.now()
              .copyWith(month: index + 1, day: Random().nextInt(27) + 1),
          currentMonth: DateMonth.now().copyWith(month: index + 1),
          enableContinuous: Random().nextBool(),
          firstSelectDay: DateDay.now()
              .copyWith(month: index + 1, day: Random().nextInt(15) + 1),
          secondSelectDay: DateDay.now()
              .copyWith(month: index + 1, day: Random().nextInt(12) + 15),
          enableMultiple: Random().nextBool(),
          multipleDays: [
            DateDay.now().copyWith(month: index + 1, day: 3),
            DateDay.now().copyWith(month: index + 1, day: 5),
            DateDay.now().copyWith(month: index + 1, day: 8),
          ])));
      months
        ..add(
          Container(
            child: MonthWidget<String>(
              controller: controllers[index],
              localeType: Random().nextBool()
                  ? CalendarLocaleType.zh
                  : CalendarLocaleType.en,
            ),
          ),
        );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${DateTime.now().year}年日历'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(children: months),
    );
  }

  @override
  void dispose() {
    controllers.forEach((f) => f.dispose());
    super.dispose();
  }
}
