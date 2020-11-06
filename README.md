## mini_calendar

[![](https://img.shields.io/pub/v/mini_calendar#align=left&display=inline&height=20&originHeight=20&originWidth=76&status=done&style=none&width=76)](https://pub.flutter-io.cn/packages/mini_calendar) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/OpenFlutter/mini_calendar?style=plastic)

Date component developed with Flutter, plans to support display, swipe left and right, add date mark, radio, display week, etc.

使用Flutter开发的日期组件，计划支持显示，左右滑动，添加日期标记，单选，显示星期等功能。

- [更新记录](CHANGELOG.md)


### 主要想实现的内容

![功能设计](https://upload-images.jianshu.io/upload_images/14097955-e322a37f80d25deb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 使用
### 引入库
```dart
dependencies:
  mini_calendar: ^0.3.2
```
### 导包
```dart
import 'package:mini_calendar/mini_calendar.dart';
```

### 月视图(MonthWidget)
```dart
MonthWidget();// 默认当月
```


- 可通过控制器参数来控制显示的月份以及选择的日期

```dart
MonthWidget(
  controller: MonthController.init(
      MonthOption<String>(
        currentDay: DateDay.now().copyWith(month: index + 1, day: Random().nextInt(27) + 1),
        currentMonth: DateMonth.now().copyWith(month: index + 1),
      )
  ),
)
```


- 支持显示连选

```dart
MonthWidget(
  controller: MonthController.init(MonthOption(
    currentMonth: DateMonth.now().copyWith(month: 1),
    enableContinuous: true,
    firstSelectDay: DateDay.now().copyWith(month: 1, day: 8),
    secondSelectDay: DateDay.now().copyWith(month: 1, day: 18),
  )),
)
```
- 支持多选

```dart
MonthWidget(
  controller: MonthController.init(MonthOption(
    currentMonth: DateMonth.now().copyWith(month: 1),
    enableMultiple: true,
    multipleDays: [
            DateDay.now().copyWith(month: 1, day: 3),
            DateDay.now().copyWith(month: 1, day: 5),
            DateDay.now().copyWith(month: 1, day: 8),
          ],
  )),
)
```

- 支持添加标记
- ……

![image.png](https://cdn.nlark.com/yuque/0/2019/png/179485/1576584797091-8f86bb0c-b470-49c7-85dd-00f68febca94.png)



<a name="PzRDh"></a>
### 滚动日历(MonthPageView)

> 控制器需要创建后获取 `onCreated`

```dart
MonthPageView(
  padding: EdgeInsets.all(1),
  scrollDirection: Axis.horizontal,// 水平滑动或者竖直滑动
  option: MonthOption(
    enableContinuous: true,// 单选、连选控制
    marks: { 
      DateDay.now().copyWith(day: 1): '111',
      DateDay.now().copyWith(day: 5): '222',
      DateDay.now().copyWith(day: 13): '333',
      DateDay.now().copyWith(day: 19): '444',
      DateDay.now().copyWith(day: 26): '444',
    },
  ),
  showWeekHead: true, // 显示星期头部
  onContinuousSelectListen: (firstDay, endFay) {
  },// 连选回调
  onMonthChange: (month) {
  },// 月份更改回调
  onDaySelected: (day, data) {
  },// 日期选中会迪欧啊
  onCreated: (controller){
  }, // 控制器回调
),
```

<a name="BuYna"></a>
### 控制器
<a name="7mWMM"></a>
#### 参数初始化
```dart
MonthOption({
    DateDay currentDay,//选择的日期
    DateMonth currentMonth,//当前月份
    int firstWeek = 7,//第一列显示的星期 [1,7]
    DateDay firstSelectDay,//连选第一个日期
    DateDay secondSelectDay,//连选第二个日期
    bool enableContinuous = false,//是否支持连选
    Map<DateDay, T> marks = const {},//标记
    DateDay minDay,//可选的最小日期
    DateDay maxDay,//可选的最大日期
  });
```
<a name="Ym5vA"></a>
#### 注销
```dart
MonthPageController#dispose();
```
<a name="cmGVq"></a>
#### 更新
```dart
MonthPageController#reLoad();
```
<a name="lWF7m"></a>
#### 下一月
```dart
MonthPageController#next();
```
<a name="PqzYu"></a>
#### 上一月
```dart
MonthPageController#last();
```
<a name="cVKdI"></a>
#### 跳转到指定月份
```dart
MonthPageController#goto(DateMonth month);
```

![演示](https://upload-images.jianshu.io/upload_images/14097955-88d9957dbdc0c533.gif?imageMogr2/auto-orient/strip|imageView2/2/w/499/format/webp)

### 高级功能
> 自定义

#### 自定义月视图背景
```dart
buildMonthBackground: (_, width, height, month) => Image.network(
    'https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/b0c57bd90abd49d59920924010ab66a9.png!sswm',
    height: height,
    width: width,
    fit: BoxFit.cover,
    ),
```

#### 自定义月视图头部

```dart
buildMonthHead: (ctx, width, height, month) => Container(
padding: EdgeInsets.all(5),
child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
    Text(
      "${month.year}年",
      style: TextStyle(fontSize: 40, color: Colors.white),
    ),
    Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 1,
      color: Colors.yellow,
      height: 50,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${month.month}月",
          style: TextStyle(fontSize: 18, color: Colors.orange),
        ),
        Text("这是一个自定义的月头部"),
      ],
    )
  ],
),
),
```

- 自定义星期头部
- 自定义日视图
- ……

|![image.png](https://cdn.nlark.com/yuque/0/2019/png/179485/1576584839283-c713cc7e-c932-4d7f-8033-888a7b7505f2.png)|![image.png](https://cdn.nlark.com/yuque/0/2019/png/179485/1576584857241-5a4a8bb1-fe4b-4fd2-b4c6-be03b68ddefc.png)|
| :---: | :---: |


> 更多功能clone项目，运行demo

### 开源不易，老铁们多多支持，点赞也是支持 😃 ！

