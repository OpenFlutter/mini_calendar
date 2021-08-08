enum CalendarLocaleType { en, zh }

final _i18nModel = {
  'en': {
    'today': 'Today',
    'last': 'Last',
    'next': 'Next',
    'goto': 'GoTo',
    'weekShort': [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thur',
      'Fri',
      'Sat',
    ],
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]
  },
  'zh': {
    'today': '今',
    'last': '上一月',
    'next': '下一月',
    'goto': '跳转',
    'weekShort': ['日', '一', '二', '三', '四', '五', '六'],
    'monthShort': [
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月'
    ]
  }
};

Map<String, dynamic> i18nObjInLocal(CalendarLocaleType type) {
  switch (type) {
    case CalendarLocaleType.en:
      return _i18nModel['en']!;
    case CalendarLocaleType.zh:
      return _i18nModel['zh']!;
    default:
      return _i18nModel['zh']!;
  }
}
