import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import '../model/date_day.dart';

/// 日视图
class DayWidget<T> extends StatelessWidget {
  /// 当前显示的日期
  final DateDay dayTime;

  /// 日期颜色
  final TextStyle style;

  /// 是否可选
  final bool edit;

  /// 是否有标签
  final bool hasMark;

  /// 自定义构建标记
  final BuildMark<T> buildMark;

  /// 点击事件
  final OnDaySelected<T> onDaySelected;

  /// 高度
  final double height;

  /// 宽度
  final double width;

  /// 附加数据
  final T data;

  /// 是否被选中
  final DateDay currentDay;

  const DayWidget({
    Key key,
    this.hasMark,
    this.dayTime,
    this.style,
    this.edit = true,
    this.height = double.infinity,
    this.width = double.infinity,
    this.buildMark,
    this.data,
    this.onDaySelected,
    this.currentDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = style;
    Color _sideColor = Colors.grey[200];
    if (dayTime.weekday > 5) {
      _style = style.copyWith(color: edit ? Colors.pink[300] : Colors.pink[200]);
    }
    if (dayTime.isToday()) {
      _style = style.copyWith(color: Colors.green);
      _sideColor = Colors.green;
    }
    if (currentDay != null && currentDay == dayTime) {
      _sideColor = Colors.blue;
    }

    List<Widget> items = [Center(child: Text("${dayTime.day}${hasMark ? '' : ''}", style: _style))];
    if (hasMark) {
      items.add(buildMark == null
          ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(Icons.bookmark, color: Colors.blue, size: 16),
              ),
            )
          : buildMark(context, dayTime, data));
    }

    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: BorderSide(
            width: 0.5,
            color: _sideColor,
          )),
      child: Ink(
        child: InkWell(
          onTap: () {
            if (onDaySelected != null && edit) {
              onDaySelected(dayTime, data);
            }
          },
          child: Container(
            height: height,
            width: width,
            child: Stack(children: items),
          ),
        ),
      ),
    );
  }
}
