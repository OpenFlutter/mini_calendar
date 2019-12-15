import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mini_calendar/controller/month_page_controller.dart';
import 'package:mini_calendar/model/date_month.dart';
import 'package:mini_calendar/model/month_option.dart';

import '../handle.dart';
import '../mini_calendar.dart';
import 'month_widget.dart';

class MonthPageView<T> extends StatefulWidget {
  /// 配置参数
  final MonthOption<T> option;

  /// 月份滑动改变
  final ValueChanged<DateMonth> onMonthChange;

  /// 自定义构建标记
  final BuildMark<T> buildMark;

  /// 边距
  final EdgeInsets padding;

  /// 面板颜色
  final Color color;

  /// 面板宽度,默认屏宽
  final double width;

  /// 日组件高度
  final double dayHeight;

  /// 点击事件
  final OnDaySelected<T> onDaySelected;

  /// 显示日期头部
  final bool showWeekHead;

  /// 构建周抬头
  final BuildWeekHead buildWeekHead;

  /// 滚动方向
  final Axis scrollDirection;

  /// 是否可以滑动翻页
  final bool pageSnapping;

  /// 创建后回调
  final ValueChanged<MonthPageController<T>> onCreated;

  /// 连选监听
  final OnContinuousSelectListen onContinuousSelectListen;

  const MonthPageView({
    Key key,
    this.onMonthChange,
    this.buildMark,
    this.option,
    this.padding = EdgeInsets.zero,
    this.color = Colors.white,
    this.width,
    this.dayHeight,
    this.onDaySelected,
    this.showWeekHead,
    this.buildWeekHead,
    this.scrollDirection = Axis.horizontal,
    this.pageSnapping = true,
    this.onCreated,
    this.onContinuousSelectListen,
  }) : super(key: key);

  @override
  _MonthPageViewState<T> createState() => _MonthPageViewState<T>();
}

class _MonthPageViewState<T> extends State<MonthPageView<T>> {
  PageController _controller = PageController(initialPage: CACHE_SIZE ~/ 2);
  MonthPageController<T> _monthPageController;

  double _width;

  @override
  void initState() {
    _monthPageController = MonthPageController<T>()..init(widget.option);
    _controller.addListener(() {
      double position = _controller.position.pixels;
      if (position == 0) {
        _monthPageController.addFirstMonth();
        _controller.jumpToPage(1);
      } else if (position == _controller.position.maxScrollExtent) {
        _monthPageController.addMonth();
        if (_monthPageController.monthList.length == CACHE_SIZE) {
          print("pageSize:${_monthPageController.monthList.length},page:${CACHE_SIZE - 2}");
          _controller.jumpToPage(CACHE_SIZE - 2);
        }
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (widget.onCreated != null) {
        widget.onCreated(_monthPageController);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = widget.width ?? MediaQuery.of(context).size.width;
    List<Widget> items = [
      Expanded(
          child: StreamBuilder<List<DateMonth>>(
              stream: _monthPageController.monthListStream(),
              initialData: _monthPageController.monthList,
              builder: (ctx, data) {
                return PageView(
                  controller: _controller,
                  scrollDirection: widget.scrollDirection,
                  pageSnapping: widget.pageSnapping,
                  onPageChanged: (position) {
                    if (widget.onMonthChange != null) {
                      widget.onMonthChange(_monthPageController.monthList[position]);
                    }
                  },
                  children: _monthPageController.monthList.map((month) {
                    return MonthWidget(
                      dayHeight: widget.dayHeight,
                      width: _width,
                      controller: _monthPageController.getMonthController(month)..setCurrentMonth(month),
                      color: widget.color,
                      buildMark: widget.buildMark,
                      showWeekHead: false,
                      padding: widget.padding,
                      onDaySelected: _onDaySelected,
                    );
                  }).toList(),
                );
              }))
    ];
    if (widget.showWeekHead) {
      items.insert(
        0,
        Container(
          width: _width,
          padding: EdgeInsets.only(left: widget.padding.left, right: widget.padding.right, top: 5, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              int week = (widget.option.firstWeek + index) % 7;
              return Container(
                alignment: Alignment.center,
                child: widget.buildWeekHead != null
                    ? widget.buildWeekHead(context, week)
                    : defaultBuildWeekHead(context, week),
              );
            }),
          ),
        ),
      );
    }
    return Column(children: items);
  }

  void _onDaySelected(DateDay day, T data) {
    if (_monthPageController.option.enableContinuous) {
      DateDay firstDay = _monthPageController.option.firstSelectDay;
      DateDay secondDay = _monthPageController.option.secondSelectDay;
      if (firstDay == null) {
        firstDay = day.copyWith();
        secondDay = null;
      } else if (secondDay == null) {
        if (firstDay > day) {
          secondDay = firstDay.copyWith();
          firstDay = day.copyWith();
        } else {
          secondDay = day.copyWith();
        }
      } else {
        if (day >= firstDay && day <= secondDay) {
          secondDay = day.copyWith();
        } else {
          firstDay = null;
          secondDay = null;
        }
      }
      _monthPageController
        ..setContinuousDay(firstDay, secondDay)
        ..reLoad();
      if (widget.onContinuousSelectListen != null) {
        widget.onContinuousSelectListen(firstDay, secondDay);
      }
    } else {
      _monthPageController
        ..setCurrentDay(day.copyWith())
        ..reLoad();
      if (widget.onDaySelected != null) {
        widget.onDaySelected(day.copyWith(), data);
      }
    }
  }
}
