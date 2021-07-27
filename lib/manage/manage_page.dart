import 'package:flutter/material.dart';
import 'package:logistics/comm/logistic_dio.dart';
import 'package:logistics/manage/track/track_page.dart';

import 'order/order_page.dart';

class ManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ManagePageState();
  }
}

class _ManagePageState extends State<ManagePage> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    handleUnauthorized(context);
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          tabBar(),
          Container(color: Theme.of(context).dividerColor, width: 1),
          pageView(),
        ],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      width: 160,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              pageController.jumpToPage(0);
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 64)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(
                  currentPage == 0 ? Colors.blue[100] : null),
            ),
            child: Text("订单管理"),
          ),
          Divider(),
          TextButton(
            onPressed: () {
              pageController.jumpToPage(1);
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 64)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder()),
              backgroundColor: MaterialStateProperty.all(
                  currentPage == 1 ? Colors.blue[100] : null),
            ),
            child: Text("轨迹管理"),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget pageView() {
    return Expanded(
      child: PageView(
        onPageChanged: (page) {
          currentPage = page;
          setState(() {});
        },
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [OrderPage(), TrackPage()],
      ),
    );
  }

  void handleUnauthorized(BuildContext context) {
    onUnauthorized = () {
      Navigator.of(context).pushReplacementNamed("login");
    };
  }
}
