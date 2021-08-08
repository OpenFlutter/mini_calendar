import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../model/calendar_i18n_model.dart';

import 'month_widget.dart';
import '../handle.dart';
import '../mini_calendar.dart';
import '../controller/month_page_controller.dart';
import '../model/date_month.dart';
import '../model/month_option.dart';

///
/// 翻页日历 <br/>
///
/// Create by JsonYe<597232387@qq.com> on 2019/12
///
class MonthPageView<T> extends StatefulWidget {
  /// 配置参数
  final MonthOption<T> option;

  /// 月份滑动改变
  final ValueChanged<DateMonth>? onMonthChange;

  /// 自定义构建标记
  final BuildMark<T>? buildMark;

  /// 边距
  final EdgeInsets padding;

  /// 面板颜色
  final Color? color;

  /// 日历面板宽度,默认屏宽
  final double? width;

  /// 日历面板宽度,默认屏宽的 6/7
  final double? height;

  /// 点击事件
  final OnDaySelected<T>? onDaySelected;

  /// 多选监听
  final ValueChanged<List<DateDay>>? onMultipleSelectListen;

  /// 显示星期头部
  final bool showWeekHead;

  /// 星期头部背景色
  final Color? weekHeadColor;

  /// 构建星期头部
  final BuildWeekHead? buildWeekHead;

  /// 是否显示月视图头部
  final bool showMonthHead;

  /// 月视图头部背景色
  final Color? monthHeadColor;

  /// 构建月视图头部
  final BuildWithMonth? buildMonthHead;

  /// 滚动方向
  final Axis scrollDirection;

  /// 是否可以滑动翻页
  final bool pageSnapping;

  /// 国际化语言类型
  final CalendarLocaleType? localeType;

  /// 创建后回调
  final ValueChanged<MonthPageController<T>>? onCreated;

  /// 连选监听
  final OnContinuousSelectListen? onContinuousSelectListen;

  final VoidCallback? onClear;

  const MonthPageView(
    this.option, {
    Key? key,
    this.onMonthChange,
    this.buildMark,
    this.padding = EdgeInsets.zero,
    this.color = Colors.white,
    this.width,
    this.height,
    this.onDaySelected,
    this.showWeekHead = true,
    this.buildWeekHead,
    this.scrollDirection = Axis.horizontal,
    this.pageSnapping = true,
    this.onCreated,
    this.onContinuousSelectListen,
    this.showMonthHead = true,
    this.buildMonthHead,
    this.weekHeadColor = Colors.white,
    this.monthHeadColor = Colors.white,
    this.localeType = CalendarLocaleType.zh,
    this.onMultipleSelectListen,
    this.onClear,
  }) : super(key: key);

  @override
  _MonthPageViewState<T> createState() => _MonthPageViewState<T>();
}

class _MonthPageViewState<T> extends State<MonthPageView<T>> {
  PageController _controller = PageController(initialPage: CACHE_SIZE ~/ 2);
  final MonthPageController<T> _monthPageController = MonthPageController<T>();

  @override
  void initState() {
    _monthPageController.init(widget.option, pageController: _controller);
    if (widget.onMonthChange != null) {
      _monthPageController.positionStream().listen((position) =>
          widget.onMonthChange!(_monthPageController.monthList[position]));
    }
    SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      if (widget.onCreated != null) {
        widget.onCreated!(_monthPageController);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = widget.width ?? MediaQuery.of(context).size.width;
    double _height = widget.height ?? _width * 5.5 / 7.0;
    List<Widget> items = [
      Container(
          height: _height,
          width: _width,
          child: StreamBuilder<List<DateMonth>>(
              stream: _monthPageController.monthListStream(),
              initialData: _monthPageController.monthList,
              builder: (ctx, data) {
                return PageView(
                  controller: _controller,
                  scrollDirection: widget.scrollDirection,
                  pageSnapping: widget.pageSnapping,
                  onPageChanged: _monthPageController.changePosition,
                  children: _monthPageController.monthList.map((month) {
                    return MonthWidget<T>(
                      width: _width,
                      controller: _monthPageController.getMonthController(month)
                        ..setCurrentMonth(month),
                      color: widget.color ?? Colors.transparent,
                      buildMark: widget.buildMark,
                      showWeekHead: false,
                      showMonthHead: false,
                      padding: widget.padding,
                      onMultipleSelectListen: (days) {
                        _monthPageController
                          ..setMultipleDays(days)
                          ..reLoad();
                        if (widget.onMultipleSelectListen != null) {
                          widget.onMultipleSelectListen!(days);
                        }
                      },
                      localeType: widget.localeType ?? CalendarLocaleType.zh,
                      onDaySelected: (day, data, enable) {
                        if (enable) {
                          _monthPageController
                            ..setCurrentDay(day)
                            ..reLoad();
                        }
                        if (day > month.monthEndDay) {
                          _monthPageController.next();
                        } else if (day < month.monthFirstDay) {
                          _monthPageController.last();
                        } else {
                          if (widget.onDaySelected != null)
                            widget.onDaySelected!(day, data, enable);
                        }
                      },
                      onContinuousSelectListen: (firstDay, secondDay) {
                        _monthPageController
                          ..setContinuousDay(firstDay, secondDay)
                          ..reLoad();
                        if (widget.onContinuousSelectListen != null)
                          widget.onContinuousSelectListen!(firstDay, secondDay);
                      },
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
          height: 36,
          color: widget.weekHeadColor,
          padding: EdgeInsets.only(
              left: widget.padding.left,
              right: widget.padding.right,
              top: 5,
              bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              int week = (widget.option.firstWeek + index) % 7;
              return Container(
                alignment: Alignment.center,
                child: widget.buildWeekHead != null
                    ? widget.buildWeekHead!(context, week)
                    : defaultBuildWeekHead(
                        context,
                        week,
                        localeType: widget.localeType ?? CalendarLocaleType.zh,
                      ),
              );
            }),
          ),
        ),
      );
    }
    if (widget.showMonthHead) {
      items.insert(
        0,
        Container(
          width: _width,
          color: widget.monthHeadColor,
          padding: EdgeInsets.only(
              left: widget.padding.left,
              right: widget.padding.right,
              top: 5,
              bottom: 5),
          child: StreamBuilder<int>(
              stream: _monthPageController.positionStream(),
              initialData: _monthPageController.position,
              builder: (ctx, data) {
                int? _data = data.data;
                if (_data == null) return Container();
                return widget.buildMonthHead != null
                    ? widget.buildMonthHead!(context, _width, double.infinity,
                        _monthPageController.monthList[_data])
                    : defaultBuildMonthHead(
                        context,
                        _monthPageController.monthList[_data],
                        onLast: () => _monthPageController.last(),
                        onNext: () => _monthPageController.next(),
                        onClear: widget.onClear,
                      );
              }),
        ),
      );
    }
    return Column(children: items);
  }
}
