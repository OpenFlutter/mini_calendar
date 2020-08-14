import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_calendar/model/i18n_model.dart';

import 'model/date_day.dart';

/// 默认构建星期标题
Widget defaultBuildWeekHead(BuildContext context, int week, {LocaleType localeType = LocaleType.zh}) {
  switch (week) {
    case 1:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.black87));
    case 2:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.black87));
    case 3:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.black87));
    case 4:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.black87));
    case 5:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.black87));
    case 6:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.pink));
    case 0:
      return Text(i18nObjInLocal(localeType)['weekShort'][week], style: TextStyle(fontSize: 12, color: Colors.pink));
  }
  return Container();
}

/// 默认构建标记
Widget defaultBuildMark<T>({BuildContext context, DateDay day, T data}) {
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
  return Text("${month.month}", style: TextStyle(fontSize: 120, color: Colors.black12));
}

/// 默认构建月视图头部
Widget defaultBuildMonthHead(BuildContext context, DateMonth month, {VoidCallback onLast, VoidCallback onNext}) {
  return Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        onLast == null ? Container() : IconButton(icon: Icon(Icons.chevron_left), onPressed: onLast),
        Text(month.toString(), style: TextStyle(fontSize: 20)),
        onNext == null ? Container() : IconButton(icon: Icon(Icons.chevron_right), onPressed: onNext),
      ],
    ),
  );
}

/// 默认构建年视图头部
Widget defaultBuildYearHead(BuildContext context, int year, {VoidCallback onLast, VoidCallback onNext}) {
  return Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        onLast == null ? Container() : IconButton(icon: Icon(Icons.chevron_left), onPressed: onLast),
        Text("$year", style: TextStyle(fontSize: 20)),
        onNext == null ? Container() : IconButton(icon: Icon(Icons.chevron_right), onPressed: onNext),
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
Widget defaultBuildDayItem<T>(BuildContext context,
    {DateDay dayTime,
    bool enableSelect,
    bool hasMark,
    double height,
    double width,
    T markData,
    Color weekColor = Colors.blue,
    Color weekendColor = Colors.pink,
    bool isSelected = false,
    bool isContinuous = false,
    bool isMultiple = false,
    BuildMark<T> buildMark,
    OnDaySelected<T> onDaySelected,
    LocaleType localeType = LocaleType.zh}) {
  Color _sideColor = Colors.grey[200];
  Color _dayColor = Colors.transparent;
  TextStyle _style;
  if (!enableSelect) {
    _style = TextStyle(fontSize: 12, color: dayTime.weekday > 5 ? weekendColor.withAlpha(80) : weekColor.withAlpha(80));
  } else {
    _style = TextStyle(fontSize: 12, color: dayTime.weekday > 5 ? weekendColor : weekColor);
  }
  if (isSelected) {
    _dayColor = Colors.blue.withAlpha(200);
    _style = _style.copyWith(color: Colors.white);
  }
  if (isMultiple || (!isMultiple && isContinuous)) {
    _sideColor = Colors.deepOrange;
  }

  List<Widget> items = [Center(child: Text("${dayTime.day}${hasMark ? '' : ''}", style: _style))];
  if (dayTime.isToday()) {
    items.add(Positioned(
      top: 2,
      right: 2,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(side: BorderSide(width: 0.3, color: Colors.pinkAccent)),
        child: Padding(
          padding: EdgeInsets.all(1),
          child:
              Text(i18nObjInLocal(localeType)['today'], style: _style.copyWith(fontSize: 10, color: Colors.pinkAccent)),
        ),
      ),
    ));
  }
  if (hasMark) {
    items.add(buildMark == null ? defaultBuildMark() : buildMark(context, dayTime, markData));
  }

  return Material(
    color: _dayColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: BorderSide(
          width: 0.5,
          color: _sideColor,
        )),
    child: Ink(
      child: InkWell(
        onTap: () {
          if (onDaySelected != null && enableSelect) {
            onDaySelected(dayTime, markData);
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

/// 构建星期头  <br/>
/// [context] - 上下文  <br/>
/// [week] - 星期数字： 0-周日，1-周一，2-周二，3-周三，4-周四，5-周五，6-周六
typedef BuildWeekHead = Widget Function(BuildContext context, int week);

/// 构建月相关控件  <br/>
/// [context] - 上下文  <br/>
/// [month] - 所在月份
typedef BuildWithMonth = Widget Function(BuildContext context, double width, double height, DateMonth month, {VoidCallback onLast, VoidCallback onNext});

/// 构建年相关控件  <br/>
/// [context] - 上下文  <br/>
/// [month] - 所在月份
typedef BuildWithYear = Widget Function(BuildContext context, double width, double height, int year);

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
typedef BuildWithDay<T> = Widget Function(BuildContext context,
    {DateDay dayTime,
    bool enableSelect,
    bool hasMark,
    double height,
    double width,
    T markData,
    Color weekColor,
    Color weekendColor,
    bool isSelected,
    bool isContinuous,
    bool isMultiple,
    BuildMark<T> buildMark,
    OnDaySelected<T> onDaySelected});

/// 构建Mark  <br/>
/// [context] - 上下文  <br/>
/// [day] - 所在日期  <br/>
/// [data] - 若存在mark则返回mark的内容
typedef BuildMark<T> = Widget Function(BuildContext context, DateDay day, T data);

/// 当日期被选中时回调  <br/>
/// [day] - 选中的日期   <br/>
/// [markData] - 若存在mark则返回mark的内容
typedef OnDaySelected<T> = void Function(DateDay day, T markData);

/// 连选回调  <br/>
/// [firstDay]-开始日期  <br/>
/// [secondDay]-结束时间
typedef OnContinuousSelectListen = void Function(DateDay firstDay, DateDay secondDay);
