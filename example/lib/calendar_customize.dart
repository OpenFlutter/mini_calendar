import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';

/// 自定义日历
class CalendarCustomizePage extends StatefulWidget {
  @override
  _CalendarCustomizePageState createState() => _CalendarCustomizePageState();
}

class _CalendarCustomizePageState extends State<CalendarCustomizePage> {
  List<Widget> months = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    months.clear();
    months.add(MonthWidget(
      controller: MonthController.init(MonthOption(
        currentMonth: DateMonth.now().copyWith(month: 1),
        enableContinuous: true,
        firstSelectDay: DateDay.now().copyWith(month: 1, day: 8),
        secondSelectDay: DateDay.now().copyWith(month: 1, day: 18),
      )),
      monthHeadColor: Colors.purpleAccent,
      weekHeadColor: Colors.orangeAccent,
      buildMonthBackground: (_, width, height, month) => Image.network(
        'https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/b0c57bd90abd49d59920924010ab66a9.png!sswm',
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
      weekColor: Colors.black87,
      weekendColor: Colors.deepOrange,
    ));
    months.add(Divider());
    months.add(MonthWidget(
      controller: MonthController.init(
        MonthOption<String>(
          currentMonth: DateMonth.now().copyWith(month: 7),
          currentDay: DateDay.now().copyWith(month: 7, day: 17),
          marks: {
            DateDay.now().copyWith(month: 7, day: 3): '111',
            DateDay.now().copyWith(month: 7, day: 8): '222',
            DateDay.now().copyWith(month: 7, day: 17): '333',
            DateDay.now().copyWith(month: 7, day: 21): '444',
            DateDay.now().copyWith(month: 7, day: 30): '444',
          },
        ),
      ),
      showMonthHead: true,
      monthHeadColor: Colors.greenAccent,
      buildMonthHead: (ctx, width, height, month) => Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "${month.year}年",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              width: 1,
              color: Colors.yellow,
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${month.month}月",
                  style: TextStyle(fontSize: 18, color: Colors.orange),
                ),
                Text("这是一个自定义的月头部"),
              ],
            )
          ],
        ),
      ),
      showWeekHead: true,
      weekHeadColor: Colors.orangeAccent,
      buildWeekHead: defaultBuildWeekHead,
      color: Colors.white,
      weekendColor: Colors.purple,
      weekColor: Colors.blue,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      buildDayItem: defaultBuildDayItem,
      buildMark: (ctx, day, data) => Positioned(
        bottom: 3,
        left: 0,
        right: 0,
        child: Center(
          child: Icon(
            Icons.access_time,
            color: Colors.purpleAccent,
            size: 12,
          ),
        ),
      ),
      showBackground: true,
      buildMonthBackground: (ctx, width, height, month) => Image.network(
        "https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/99eb5a4758ae4d44b2e336da92a30df5.png!sswm",
        fit: BoxFit.fill,
        width: width,
        height: height,
      ),
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义${DateTime.now().year}年日历'),
        centerTitle: true,
      ),
      body: ListView(children: months),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
