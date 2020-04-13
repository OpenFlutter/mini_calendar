# mini_calendar

Date component developed with Flutter, plans to support display, swipe left and right, add date mark, radio, display week, etc.

使用Flutter开发的日期组件，计划支持显示，左右滑动，添加日期标记，单选，显示星期等功能。


## 开发日记
### 2019-12-09 记
> 主要想实现的内容

![功能设计](https://upload-images.jianshu.io/upload_images/14097955-e322a37f80d25deb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 2019-12-10 记
> 整体上，从简单的显示开始，然后再加入交互和控制功能。第一版显示方面，先考虑实现最常用的月视图。

#### 月视图实现
> 日历的月视图，是非常规则的表格形式。所以就考虑用GridView来实现。

1. 写两个类，来管理月和日，并重构了比较运算符。

```dart
/// 月
class DateMonth {
  int year;
  int month;
  int maxDays; 
	// ……
}

/// 日
class DateDay extends DateMonth{
  int day;
  // ……
}


```

2. 在写月视图时，需要考虑开始星期所在位置，非当月日期的显示情况等。这里的关键在于计算位置。



### 2019-12-12 记
> 由于GridView在控制高度上面有所不便（可能有好多方法，我没有尝试到），我换成了Warp的方式来实现。

#### 切换月份
> 常见的月份切换方式，有类似小米的左右滑动切换，也有上下滑动切换。第一个想到的就是用PageView来实现该功能。

问题：如何实现无限切换？

1. 构建前，全部加载完成，然后就可以随意切换了。否决，不够灵活，性能开销大。
1. 动态分配，初始化3页，然后监听滑动，动态首尾动态添加对应月份。可以考虑，但跨度大了，数据会不断膨胀，可以再优化下。
1. 动态分配，动态移除，设定缓存大小，超出缓存范围的将被移除。可以，那就按照这个方案进行！

问题：如何实现动态分配？
> 原理如下，先动态分配数据，然后跳转到指定页面。若考虑缓存机制，可在remove前加判断即可。

![image.png](https://cdn.nlark.com/yuque/0/2019/png/179485/1576167627925-f9a55fd4-bcd9-4c12-b808-79bb74f6eab8.png#align=left&display=inline&height=281&name=image.png&originHeight=281&originWidth=720&size=28161&status=done&style=none&width=720)

> 下面是核心代码


```dart
List<int> pages = [-1, 0, 1];
PageController _controller = PageController(initialPage: 1);
_controller.addListener(() {
  double position = _controller.position.pixels;
  if (position == 0) {
    pages.insert(0, pages.first - 1);
    pages.remove(pages.last);
    _controller.jumpToPage(1);
  } else if (position == _controller.position.maxScrollExtent) {
    pages.add(pages.last + 1);
    pages.remove(pages.first);
    _controller.jumpToPage(1);
  } else {
    return;
  }
  setState((){});
});
```
有了上面的基础，切换月份，也就变成一件简单的事情了。
### 2019-12-14 记
#### 实现简单日历
![日历.gif](https://cdn.nlark.com/yuque/0/2019/gif/179485/1576424449186-d5ef3e7f-099d-4c7c-8db1-c21e5c88fde6.gif#align=left&display=inline&height=888&name=%E6%97%A5%E5%8E%86.gif&originHeight=973&originWidth=548&size=529806&status=done&style=shadow&width=500)
#### 连选实现
> 主要是处理日期选中后的赋值问题。

当下的处理逻辑有很多，我这里采用的是以下逻辑：

1. 单选和连选只同时支持一种（理论上可以同时支持，后续可以再优化实现）
1. 第一次选择日期，给到开始日期上。
1. 第二次选择日期，将小日期给到开始日期，大日期给到结束日期上。
1. 第三次选择日期，当落在小、大之间时，更换大日期。当不落在之间时，小、大日期全部清空。相当于取消选择。

### 2019-12-15 记
#### 实现可单选、连选、左右滑动日历控件

- 月视图添加背景
- 可自定义起始星期
- 可自定义实现周头部控件
- 可自定义实现标记组件
- 利用[切换月份](#%E5%88%87%E6%8D%A2%E6%9C%88%E4%BB%BD)和[连选实现](#%E8%BF%9E%E9%80%89%E5%AE%9E%E7%8E%B0)完成左右切换的可单选、连选的日期控件

### 2019-12-24 记
#### 支持国际化

### 2020-04-13 记
#### 支持多选


![演示](https://upload-images.jianshu.io/upload_images/14097955-88d9957dbdc0c533.gif)
