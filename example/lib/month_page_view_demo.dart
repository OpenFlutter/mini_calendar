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
  List<DateDay> _days = [];
  int _selectType = 1;
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('翻页日历'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSelectTime(),
            MonthPageView(
              width: 400,
              padding: EdgeInsets.all(1),
              scrollDirection: Axis.horizontal,
              option: MonthOption(
                enableContinuous: _selectType == 2,
                // marks: {
                //   DateDay.now().copyWith(day: 1): '111',
                //   DateDay.now().copyWith(day: 5): '222',
                //   DateDay.now().copyWith(day: 13): '333',
                //   DateDay.now().copyWith(day: 19): '444',
                //   DateDay.now().copyWith(day: 26): '444',
                // },
                minDay: DateDay.now().copyWith(month: 1, day: 13),
                maxDay: DateDay.now().copyWith(month: 12, day: 21),
                enableDays: List.generate(20,
                    (index) => DateDay.now().add(Duration(days: index + 1))),
                enableMultiple: _selectType == 3,
              ),
              showWeekHead: true,
              onContinuousSelectListen: (firstDay, endFay) {
                _firstDay = firstDay;
                _secondDay = endFay;
                setState(() {});
              },
              onMultipleSelectListen: (list) {
                _days = list;
                setState(() {});
              },
              onMonthChange: (month) {
                _month = month;
                setState(() {});
              },
              onDaySelected: (day, data, enable) {
                if (enable) {
                  _day = day;
                  _data = data;
                  setState(() {});
                }
              },
              onCreated: (controller) => _controller = controller,
              localeType: CalendarLocaleType.zh,
              onClear: () {
                _controller.option.setFirstSelectDay(null);
                _controller.option.setSecondSelectDay(null);
                _controller.option.setMultipleDays([]);
                _controller.reLoad();
              },
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 3,
              children: List.generate(
                12,
                (index) => MaterialButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.3, color: Colors.pinkAccent)),
                  minWidth: 20,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text('${index + 1}'),
                  onPressed: () => _controller
                      ?.goto(DateMonth.now().copyWith(month: index + 1)),
                ),
              )..insert(0, Text('跳转月份：')),
            ),
            Container(
              child: Text(
                  '''当前月份：${_month.toString(yearSuffix: '年', monthSuffix: '月')}
可选范围：${DateDay.now().copyWith(month: 8, day: 13)} 至  ${DateDay.now().copyWith(month: 12, day: 21)} 
选择模式：${_selectType == 2 ? '连选' : _selectType == 3 ? '多选' : '单选'} 
单选日期：${_day?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}   Mark： ${_data ?? ''}
连选日期：${_firstDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}  至  ${_secondDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}
连续日期：${_days.join('，')}
'''),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSelectTime() {
    Map<int, Widget> map = {
      1: Container(width: 40, alignment: Alignment.center, child: Text('单选')),
      2: Container(width: 40, alignment: Alignment.center, child: Text('连续')),
      3: Container(width: 40, alignment: Alignment.center, child: Text('多选')),
    };
    return Container(
      alignment: Alignment.topRight,
      child: CupertinoSegmentedControl<int>(
        onValueChanged: (index) {
          _selectType = index;
          _controller?.setEnableContinuous(_selectType == 2);
          _controller?.setEnableMultiple(_selectType == 3);
          _controller.reLoad();
          setState(() {});
        },
        children: map,
        groupValue: _selectType,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
