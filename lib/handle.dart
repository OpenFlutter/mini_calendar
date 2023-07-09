import 'package:flutter/material.dart';

import 'model/calendar_i18n_model.dart';
import 'model/date_day.dart';
import 'model/date_month.dart';

/// 默认构建星期标题
Widget defaultBuildWeekHead(BuildContext context, int week,
    {CalendarLocaleType localeType = CalendarLocaleType.zh}) {
  switch (week) {
    case 1:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xd9000000)));
    case 2:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xd9000000)));
    case 3:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xd9000000)));
    case 4:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xd9000000)));
    case 5:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xd9000000)));
    case 6:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xffFF4081)));
    case 0:
      return Text(i18nObjInLocal(localeType)['weekShort'][week],
          style: TextStyle(fontSize: 16, color: Color(0xffFF4081)));
  }
  return Container();
}

/// 默认构建标记
Widget defaultBuildMark<T>({BuildContext? context, DateDay? day, T? data}) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Center(
      child: Icon(Icons.bookmark, color: Colors.pinkAccent, size: 16),
    ),
  );
}

/// 默认构建月视图背景
Widget defaultBuildMonthBackground(BuildContext context, DateMonth month) {
  return Text("${month.month}",
      style: TextStyle(fontSize: 200, color: Color(0x0b000000)));
}

/// 默认构建月视图头部
Widget defaultBuildMonthHead(BuildContext context, DateMonth month,
    {VoidCallback? onLast, VoidCallback? onNext, VoidCallback? onClear}) {
  return Stack(children: [
    Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          onLast == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.chevron_left, color: Color(0x73000000)),
                  onPressed: onLast),
          Text(month.toString(yearSuffix: '年', monthSuffix: '月'),
              style: TextStyle(fontSize: 20, color: Color(0xd9000000))),
          onNext == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.chevron_right, color: Color(0x73000000)),
                  onPressed: onNext),
        ],
      ),
    ),
    Positioned(
        top: 10,
        right: 10,
        child: onClear == null
            ? Container()
            : IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: onClear,
                color: Colors.red))
  ]);
}

/// 默认构建年视图头部
Widget defaultBuildYearHead(BuildContext context, int year,
    {VoidCallback? onLast, VoidCallback? onNext}) {
  return Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        onLast == null
            ? Container()
            : IconButton(icon: Icon(Icons.chevron_left), onPressed: onLast),
        Text("$year", style: TextStyle(fontSize: 20)),
        onNext == null
            ? Container()
            : IconButton(icon: Icon(Icons.chevron_right), onPressed: onNext),
      ],
    ),
  );
}

/// 默认构建日视图  <br/>
/// [context] - 上下文  <br/>
/// [height] - 控件高  <br/>
/// [width] - 控件宽  <br/>
/// [dayTime] - 当前日期 <br/>
/// [enableSelect] - 是否可选 <br/>
/// [hasMark] - 是否含有标记 <br/>
/// [markData] - 标记内容 <br/>
/// [weekColor] - 工作日颜色 <br/>
/// [weekendColor] - 周末颜色 <br/>
/// [isSelected] - 是否被单选 <br/>
/// [isContinuous] - 是否被连选 <br/>
/// [isMultiple] - 是否被多选 <br/>
/// [buildMark] - 自定义构建mark <br/>
/// [onDaySelected] - 选择事件 <br/>
Widget defaultBuildDayItem<T>(BuildContext context, DateDay dayTime,
    {bool enableSelect = false,
    bool hasMark = false,
    double height = 30,
    double width = 30,
    T? markData,
    Color weekColor = const Color(0xa6000000),
    Color weekendColor = const Color(0xffFF4081),
    bool isSelected = false,
    bool isContinuous = false,
    bool isMultiple = false,
    bool first = true,
    bool end = true,
    BuildMark<T>? buildMark,
    OnDaySelected<T>? onDaySelected,
    CalendarLocaleType localeType = CalendarLocaleType.zh}) {
  Color _sideColor = Colors.transparent;
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  Color _dayColor = Colors.transparent;
  TextStyle _style;
  if (!enableSelect) {
    _style = TextStyle(
        fontSize: 18,
        color: dayTime.weekday > 5
            ? weekendColor.withAlpha(65)
            : weekColor.withAlpha(80));
  } else {
    _style = TextStyle(
        fontSize: 18, color: dayTime.weekday > 5 ? weekendColor : weekColor);
  }
  if (isSelected) {
    _dayColor = Color(0xff487cff);
    borderRadius = BorderRadius.circular(5);
    _style = _style.copyWith(color: Colors.white);
  }
  if (isMultiple) {
    borderRadius = BorderRadius.circular(5);
    _sideColor = Colors.deepOrange;
  }
  if (isContinuous) {
    _dayColor = Color(0x99c9d8ff);
    if (end) {
      _dayColor = Color(0xd9487cff);
      _style = _style.copyWith(color: Colors.white);
    }
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(first ? 5 : 0),
      bottomLeft: Radius.circular(first ? 5 : 0),
      topRight: Radius.circular(end ? 5 : 0),
      bottomRight: Radius.circular(end ? 5 : 0),
    );
    _sideColor = Color(0xc9c9d8ff);
  }

  List<Widget> items = [
    Center(child: Text("${dayTime.day}${hasMark ? '' : ''}", style: _style))
  ];
  if (dayTime.isToday()) {
    items.add(Positioned(
      top: 2,
      right: 2,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.3, color: Colors.pinkAccent)),
        child: Padding(
          padding: EdgeInsets.all(1),
          child: Text(i18nObjInLocal(localeType)['today'],
              style: _style.copyWith(fontSize: 10, color: Colors.pinkAccent)),
        ),
      ),
    ));
  }
  if (hasMark) {
    items.add(buildMark == null
        ? defaultBuildMark()
        : buildMark(context, dayTime, markData));
  }

  return Padding(
    padding: EdgeInsets.only(
        top: 9, bottom: 9, left: isMultiple ? 3 : 0, right: isMultiple ? 3 : 0),
    child: Material(
      color: _dayColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          width: 0.5,
          color: _sideColor,
        ),
      ),
      child: Ink(
        child: InkWell(
          onTap: () {
            if (onDaySelected != null) {
              onDaySelected(dayTime, markData, enableSelect);
            }
          },
          child: Container(
            height: height - 18,
            width: width - (isMultiple ? 6 : 0),
            child: Stack(children: items),
          ),
        ),
      ),
    ),
  );
}

/// 构建星期头  <br/>
/// [context] - 上下文  <br/>
/// [week] - 星期数字： 0-周日，1-周一，2-周二，3-周三，4-周四，5-周五，6-周六
typedef BuildWeekHead = Widget Function(BuildContext context, int week);

/// 构建月相关控件  <br/>
/// [context] - 上下文  <br/>
/// [month] - 所在月份
typedef BuildWithMonth = Widget Function(
    BuildContext context, double width, double height, DateMonth month);

/// 构建年相关控件  <br/>
/// [context] - 上下文  <br/>
/// [month] - 所在月份
typedef BuildWithYear = Widget Function(
    BuildContext context, double width, double height, int year);

/// 默认构建日视图  <br/>
/// [context] - 上下文  <br/>
/// [height] - 控件高  <br/>
/// [width] - 控件宽  <br/>
/// [dayTime] - 当前日期 <br/>
/// [enableSelect] - 是否可选 <br/>
/// [hasMark] - 是否含有标记 <br/>
/// [markData] - 标记内容 <br/>
/// [weekColor] - 工作日颜色 <br/>
/// [weekendColor] - 周末颜色 <br/>
/// [isSelected] - 是否被单选 <br/>
/// [isContinuous] - 是否被连选 <br/>
/// [isMultiple] - 是否被多选 <br/>
/// [buildMark] - 自定义构建mark <br/>
/// [onDaySelected] - 选择事件 <br/>
typedef BuildWithDay<T> = Widget Function(BuildContext context, DateDay dayTime,
    {bool enableSelect,
    bool hasMark,
    double height,
    double width,
    T? markData,
    Color weekColor,
    Color weekendColor,
    bool isSelected,
    bool isContinuous,
    bool isMultiple,
    BuildMark<T>? buildMark,
    OnDaySelected<T> onDaySelected});

/// 构建Mark  <br/>
/// [context] - 上下文  <br/>
/// [day] - 所在日期  <br/>
/// [data] - 若存在mark则返回mark的内容
typedef BuildMark<T> = Widget Function(
    BuildContext context, DateDay day, T? data);

/// 当日期被选中时回调  <br/>
/// [day] - 选中的日期   <br/>
/// [markData] - 若存在mark则返回mark的内容<br/>
/// [enable] - 是否是可选日期
typedef OnDaySelected<T> = void Function(DateDay day, T? markData, bool enable);

/// 连选回调  <br/>
/// [firstDay]-开始日期  <br/>
/// [secondDay]-结束时间
typedef OnContinuousSelectListen = void Function(
    DateDay? firstDay, DateDay? secondDay);
