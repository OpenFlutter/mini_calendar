import 'package:flutter/material.dart';
import '../handle.dart';
import '../model/date_day.dart';

/// 日视图
class DayWidget<T> extends StatelessWidget {
  /// 当前显示的日期
  final DateDay dayTime;

  /// 日期样式
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
  final bool isSelected;

  /// 是否被连选
  final bool isContinuous;

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
    this.isSelected = false,
    this.isContinuous = false,
  })  : assert(isSelected != null && isContinuous != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style = style;
    Color _sideColor = Colors.grey[200];
    if (dayTime.weekday > 5) {
      _style = style.copyWith(color: edit ? Colors.pink[300] : Colors.pink[100]);
    }
    if (dayTime.isToday()) {
      _style = style.copyWith(color: Colors.green);
      _sideColor = Colors.green;
    }
    if (isSelected) _sideColor = Colors.blue;
    if (isContinuous) _sideColor = Colors.deepOrange;

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
      color: Colors.transparent,
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
