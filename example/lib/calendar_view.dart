import 'dart:math';

import 'package:flutter/material.dart';

import 'package:mini_calendar/mini_calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  DateDay currentDay = DateDay.now();
  DateMonth currentMonth = DateMonth.now();
  List<Widget> months = [];
  List<MonthController<String>> controllers = [];

  @override
  void initState() {
    List.generate(12, (index) {
      controllers.add(MonthController.init(MonthOption<String>(
        currentDay: currentDay,
        currentMonth: DateMonth(2019, index + 1),
        firstSelectDay: DateDay(2019, index + 1, Random().nextInt(5) + 1),
        secondSelectDay: DateDay(2019, index + 1, Random().nextInt(5) + 10),
        firstWeek: Random().nextInt(7) + 1,
        enableContinuous: Random().nextBool(),
        marks: {DateDay(2019, index + 1, Random().nextInt(27) + 1): '随机mark'},
      )));
      months
        ..add(Container(
          height: 40,
          alignment: Alignment.center,
          child: Text("2019年${index + 1}月"),
        ))
        ..add(
          Container(
            child: MonthWidget<String>(
              controller: controllers[index],
              padding: EdgeInsets.only(
                  left: Random().nextInt(15).ceilToDouble(),
                  right: Random().nextInt(15).ceilToDouble(),
                  bottom: Random().nextInt(15).ceilToDouble(),
                  top: Random().nextInt(15).ceilToDouble()),
              buildMark: (ctx, day, data) {
                return Positioned(
                    bottom: 0,
                    right: 0,
                    left: 1,
                    child: Center(
                        child: Icon(
                      Icons.access_alarm,
                      color: Colors.pink,
                      size: 14,
                    )));
              },
              color: Colors.white,
              onDaySelected: (day, data) {
                currentDay = day.copyWith();
                print(currentDay);
                if (data != null) {
                  print(data);
                }
                controllers[index]
                  ..setCurrentDay(day)
                  ..reLoad();
              },
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
        title: Text('显示日历'),
        centerTitle: true,
      ),
      body: ListView(children: months),
    );
  }

  @override
  void dispose() {
    controllers.forEach((f) => f?.dispose());
    super.dispose();
  }
}
