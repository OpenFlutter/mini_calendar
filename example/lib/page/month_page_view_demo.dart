import 'package:flutter/cupertino.dart';
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
  bool _checked = false;
  String _data = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动日历'),
        centerTitle: true,
        actions: <Widget>[
          Switch(
            value: _checked,
            activeColor: Colors.white,
            onChanged: (select) {
              _checked = select;
              if (_controller != null)
                _controller
                  ..setEnableContinuous(_checked)
                  ..reLoad();
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MonthPageView(
              padding: EdgeInsets.all(1),
              scrollDirection: Axis.horizontal,
              option: MonthOption(
                enableContinuous: _checked,
                marks: {
                  DateDay.now().copyWith(day: 1): '111',
                  DateDay.now().copyWith(day: 5): '222',
                  DateDay.now().copyWith(day: 13): '333',
                  DateDay.now().copyWith(day: 19): '444',
                  DateDay.now().copyWith(day: 26): '444',
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
              onCreated: (controller) => _controller = controller,
            ),
            Container(child: Text('''当前月份：${_month.toString(yearSuffix: '年', monthSuffix: '月')}
选择模式：${_checked ? '连选' : '单选'} 
单选日期：${_day?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}   ::   ${_data ?? ''}
连选日期：${_firstDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}  至  ${_secondDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}
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
