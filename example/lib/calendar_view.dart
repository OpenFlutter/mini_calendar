import 'package:flutter/material.dart';

import 'package:mini_calendar/mini_calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  DateDay currentDay = DateDay.now();
  DateMonth currentMonth = DateMonth.now();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> months = [];
    List.generate(12, (index) {
      months
        ..add(Container(
          height: 40,
          alignment: Alignment.center,
          child: Text("2019年${index + 1}月"),
        ))
        ..add(Container(
            width: width,
            child: MonthWidget(
              currentMonth: DateMonth(2019, index + 1),
              width: width,
              color: Colors.white,
              firstWeek: (index+1)%7,
            )));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('显示日历'),
          centerTitle: true,
        ),
        body: ListView(children: months));
  }
}
