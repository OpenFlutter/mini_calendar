import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';

class MonthPageViewDemo extends StatefulWidget {
  @override
  _MonthPageViewDemoState createState() => _MonthPageViewDemoState();
}

class _MonthPageViewDemoState extends State<MonthPageViewDemo> {
  MonthPageController _controller;
  DateMonth _month = DateMonth.now();
  DateDay _firstDay, _secondDay, _day;
  bool _checked = true;
  String _data = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动日历'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('单选'),
                Switch(
                  value: _checked,
                  onChanged: (select) {
                    _checked = select;
                    if (_controller != null)
                      _controller
                        ..setEnableContinuous(_checked)
                        ..reLoad();
                    setState(() {});
                  },
                ),
                Text('连选')
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width,
              child: MonthPageView(
                option: MonthOption(
                  currentDay: DateDay.now(),
                  enableContinuous: true,
                  marks: {
                    DateDay(2019, 12, 1): '111',
                    DateDay(2019, 12, 4): '222',
                    DateDay(2019, 12, 11): '333',
                    DateDay(2019, 12, 20): '444',
                  },
                ),
                showWeekHead: true,
                onContinuousSelectListen: (firstDay, endFay) {
                  _firstDay = firstDay;
                  _secondDay = endFay;
                  setState(() {});
                },
                onMonthChange: (month) {
                  _month = month;
                  setState(() {});
                },
                onDaySelected: (day, data) {
                  _day = day;
                  _data = data;
                  setState(() {});
                },
                onCreated: (c) => _controller = c,
              ),
            ),
            Container(child: Text('''
当前月份：$_month
选择模式：${_checked ? '连选' : '单选'} 
单选日期：${_day ?? ''}   ::   ${_data ?? ''}
连选日期：${_firstDay ?? ''}  至  ${_secondDay ?? ''}
'''), padding: EdgeInsets.all(10))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
