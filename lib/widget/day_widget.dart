import 'package:flutter/material.dart';

import '../handle.dart';

/// 日视图
class DayWidget extends StatelessWidget {
  /// 当前显示的日期
  final DateTime dayTime;

  /// 日期颜色
  final TextStyle style;

  final List<Widget> markers;

  const DayWidget({Key key, this.markers, this.dayTime, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = style;
    if (isToDay(dayTime)) {
      _style = style.copyWith(color: Colors.green);
    }
    List<Widget> items = [Text("${dayTime.day}", style: _style)];
    if (markers != null) {
      items.addAll(markers);
    }
    return Container(
      alignment: Alignment.center,
      child: Stack(children: items),
    );
  }
}
