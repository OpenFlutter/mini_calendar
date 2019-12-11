library flutter_calendar;

import 'package:flutter/cupertino.dart';
import 'package:mini_calendar/model/date_day.dart';

export 'widget/calendar_widget.dart';
export 'model/date_day.dart';
export 'model/date_month.dart';
export 'widget/month_widget.dart';

/// 构建Mark,[day]-日期，[data]-数据
typedef Widget BuildMark<T>(BuildContext context, DateDay day, T data);

/// 当日期被选中时
typedef void OnDaySelected<T>(DateDay day, T data);
