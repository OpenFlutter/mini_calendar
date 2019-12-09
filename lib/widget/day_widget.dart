import 'package:flutter/material.dart';

import '../handle.dart';

/// 日视图
class DayWidget extends StatelessWidget {
  /// 当前显示的日期
  final DateTime dayTime;

  /// 日期颜色
  final TextStyle style;

  /// 是否可选
  final bool edit;

  final List<Widget> markers;

  /// 高度
  final double height;
  final double width;

  const DayWidget({
    Key key,
    this.markers,
    this.dayTime,
    this.style,
    this.edit = true,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool tody = isToDay(dayTime);
    TextStyle _style = style;
    if (dayTime.weekday > 5) {
      _style =
          style.copyWith(color: edit ? Colors.pink[300] : Colors.pink[200]);
    }
    if (tody) {
      _style = style.copyWith(color: Colors.green);
    }

    List<Widget> items = [
      MaterialButton(
        height: height,
        minWidth: width,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(
              width: 0.5,
              color: tody ? Colors.green : Colors.grey[200],
            )),
        child: Text("${dayTime.day}", style: _style),
        onPressed: () {},
      )
    ];
    if (markers != null) {
      items.addAll(markers);
    }
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Stack(children: items),
    );
  }
}
