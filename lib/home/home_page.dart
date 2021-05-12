import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [backgroundImageWidget(), outsideNavigateWidgets()],
        ),
      ),
    );
  }

  Widget backgroundImageWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: SingleChildScrollView(
        child: Image.asset(
          "images/cycle_report_analysis_example.png",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget outsideNavigateWidgets() {
    final outsideRouteConfig = {
      "百度": "https://baidu.com",
      "腾讯": "https://qq.com",
    };

    List<Widget> widgets = [];
    outsideRouteConfig.forEach((key, value) {
      widgets.add(MaterialButton(
        onPressed: () => launch(value),
        hoverColor: Colors.blue[100],
        child: Text(key),
      ));
    });

    return Column(children: [...widgets, trackSearchEntryWidget()]);
  }

  Widget trackSearchEntryWidget() {
    return OutlinedButton(
      onPressed: () => BoostNavigator.of().push("track"),
      child: Text("轨迹查询"),
    );
  }
}
