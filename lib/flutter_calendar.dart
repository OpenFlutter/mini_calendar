library flutter_calendar;

import 'package:flutter/material.dart';
import 'package:flutter_calendar/widget/month_widget.dart';

export 'widget/month_widget.dart';

///
class FlutterCalender extends StatefulWidget {
  /// 当前选择的日期
  final DateTime pickingTime;
  const FlutterCalender({Key key, this.pickingTime}) : super(key: key);
  @override
  _FlutterCalenderState createState() => _FlutterCalenderState();
}

class _FlutterCalenderState extends State<FlutterCalender> {
  List<MonthWidget> items = [];
  PageController _controller = PageController(initialPage: 1);
  int index = 1;
  @override
  void initState() {
    items.addAll([
      MonthWidget(
        pickingDay: DateTime(widget.pickingTime.year, widget.pickingTime.month + index - 1, 1),
      ),
      MonthWidget(
        pickingDay: widget.pickingTime,
      ),
      MonthWidget(
        pickingDay: DateTime(widget.pickingTime.year, widget.pickingTime.month + index + 1, 1),
      ),
    ]);
    _controller.addListener(() {
      if (_controller.initialPage < index) {
        items.add(MonthWidget(
          pickingDay: DateTime(widget.pickingTime.year, widget.pickingTime.month + index - 1, 1),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 3,
        itemBuilder: (ctx, index) {
          return MonthWidget();
        });
  }
}
