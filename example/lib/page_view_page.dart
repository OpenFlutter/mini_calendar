import 'dart:math';

import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  @override
  _PageViewPageState createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  List<int> pages = [-1, 0, 1];
  final int cacheMax = 6;
  PageController _controller = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double position = _controller.position.pixels;
      if (position == 0) {
        pages.insert(0, pages.first - 1);
        if (pages.length > cacheMax) pages.remove(pages.last);
        _controller.jumpToPage(1);
      } else if (position == _controller.position.maxScrollExtent) {
        pages.add(pages.last + 1);
        if (pages.length > cacheMax) {
          pages.remove(pages.first);
          _controller.jumpToPage(cacheMax - 2);
        }
      } else {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pages
            .map((i) => Container(
                  alignment: Alignment.center,
                  color: Colors.blue[(1 + Random().nextInt(8)) * 100],
                  child: Text("第$i页"),
                ))
            .toList(),
        onPageChanged: (index) {},
      ),
    );
  }
}
